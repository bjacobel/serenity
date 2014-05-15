require 'date'
require 'rye'

class AwsJob < Struct.new(:pull_request)

  def perform

    # Do some setup - create an AWS object, get a keypair

    @ec2 = AWS::EC2.new(
      :access_key_id => Figaro.env.aws_key_id,
      :secret_access_key => Figaro.env.aws_key_secret
    )

    # this will wipe out the current key every time I switch from running dev to prod
    # but should do a good job of keeping the key both secret and known in prod
    if ENV['AWS_PKEY']
      @pkey = ENV['AWS_PKEY']
    else
      begin
        @pkey = @ec2.key_pairs.create("serenity").private_key
      rescue AWS::EC2::Errors::InvalidKeyPair::Duplicate
        # 'serenity' keypair already exists, so destroy it and make a new one
        @ec2.key_pairs['serenity'].delete()
        @pkey = @ec2.key_pairs.create("serenity").private_key
      end

      ENV['AWS_PKEY'] = @pkey
    end

    # make the key available to 

    # Create a new Build object
    @build = Build.new
    @build.status = "provisioning"
    @build.output = "Provisioning an Amazon EC2 instance..."
    @build.save()

    # request a spot instance

    request = @ec2.client.request_spot_instances({
      :spot_price => "0.0075",  # youtu.be/M8KrUWeBt_s
      :instance_count => 1,
      :type => "one-time",
      :valid_until => DateTime.now.advance(:hours => 1), # wait up to an hour if neccesary
      :launch_specification => {
        :key_name => "serenity",
        :image_id => "ami-a18c8fc8",
        :instance_type => "m1.small",
      },
    })

    # wait until the instance has been requisitioned and booted

    loop do
      begin
        description = @ec2.client.describe_spot_instance_requests({:spot_instance_request_ids => [request[:spot_instance_request_set][0][:spot_instance_request_id]]})
        if description[:spot_instance_request_set][0][:state] == 'active'
          @instance = @ec2.instances[description[:spot_instance_request_set][0][:instance_id]]
          break
        elsif description[:spot_instance_request_set][0][:state] == 'open'
          next
        else
          break
        end
      rescue AWS::EC2::Errors::InvalidSpotInstanceRequestID::NotFound => e  # Amazon doesn't even know about the spot instance request yet
        next
      end
    end

    if @instance
      @build.status = "bootstrapping"
      @build.save()

      loop do
        if @instance.status == "running"
          break
        else
          next
        end
      end

      # Write the private key out to file, feed it to Rye, then immediately delete it
      # (This is due to Rye accepting only filepaths to keys rather than their raw content)
      f = "/tmp/awspkey.pem"
      File.open(f, 'w') { |file| file.write(@pkey) }
      
      rbox = Rye::Box.new(host=@instance.private_ip_address)

      rbox.add_keys([f])
      File.delete(f)

      rbox.switch_user('ubuntu')

      $stderr.puts rbox.uptime


      # break it down
      @instance.terminate
    else
      @build.status = "failed"
      @build.output += "Failed to get an EC2 instance."
      @build.save()
    end

  end

  def before(job)

  end

  def after(job)

  end

  def success(job)

  end

  def error(job, exception)

  end

  def failure(job)

  end

end

  