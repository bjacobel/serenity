require 'date'

class AwsJob
  @ec2 = nil
  @pkey = nil

  def self.run
    setup()
    provision()
    deploy()
    test()
    destroy()
  end

  def self.setup
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
  end

  def self.provision
    request = @ec2.client.request_spot_instances({
      :dry_run => true,
      :spot_price => "0.0075",  # youtu.be/M8KrUWeBt_s
      :instance_count => 1,
      :type => "one-time",
      :valid_from => DateTime.now,
      :valid_until => DateTime.now + 1/24, # wait up to an hour if neccesary
      :launch_specification => {
        :key_name => "serenity",
        :image_id => "ami-a18c8fc8",
        :instance_type => "m1.small",
      },
    })

    # wait until the instance has been requisitioned and booted
    loop do
      description = @ec2.client.describe_spot_instance_requests({:spot_instance_request_ids => [request[:spot_instance_request_set][0][:spot_instance_request_id]]})
      if description[:spot_instance_request_set][0][:state] == 'active'
        return @ec2.instance.initialize(description[:spot_instance_request_set][0][:instance_id])
      elsif description[:spot_instance_request_set][0][:state] == "closed"
        return false
      end
    end
  end

  def self.deploy

  end

  def self.test

  end

  def self.destroy

  end
end

  