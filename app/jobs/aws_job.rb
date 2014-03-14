require 'date'
require 'capistrano/all'

class AwsJob < Struct.new(:pull_request)

  def perform

    # Do some setup - create an AWS object, get a keypair

    @ec2 = AWS::EC2.new(
      :access_key_id => Figaro.env.aws_key_id,
      :secret_access_key => Figaro.env.aws_key_secret
    )

    begin
      @pkey = @ec2.key_pairs.create("serenity").private_key
    rescue AWS::EC2::Errors::InvalidKeyPair::Duplicate
      # 'serenity' keypair already exists, so destroy it and make a new one
      # this might be a problem if more than one PR is being processed at a time? We'll see
      @ec2.key_pairs['serenity'].delete()
      @pkey = @ec2.key_pairs.create("serenity").private_key
    end

    # Create a new Build object
    @build = Build.new
    @build.status = "requisitioning"
    @build.output = "Bidding on an Amazon EC2 instance..."
    @build.save()

    # request a spot instance

    request = @ec2.client.request_spot_instances({
      :spot_price => "0.0075",  # youtu.be/M8KrUWeBt_s
      :instance_count => 1,
      :type => "one-time",
      :valid_until => DateTime.now.advance(:hours => 1), # wait up to an hour if neccesary
      :launch_specification => {
        :key_name => "serenity",
        :image_id => "ami-a18c8fc8",  # will need to change this later to run on every ami the serenity.yml specifies 
        :instance_type => "m1.small",
      },
    })

    # wait until the instance has been requisitioned and booted

    loop do
      description = @ec2.client.describe_spot_instance_requests({:spot_instance_request_ids => [request[:spot_instance_request_set][0][:spot_instance_request_id]]})
      if description[:spot_instance_request_set][0][:state] == 'active'
        @instance = @ec2.instances[description[:spot_instance_request_set][0][:instance_id]]
      else
        break
      end
    end

    if @instance


      # break it down
      @instance.terminate
    else
      @build.status("failed")
      @build.output("Failed to get an EC2 instance.")
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

  