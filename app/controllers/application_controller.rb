require 'date'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # might want to do this in several instances, so put it here rather than in any specific controller
  protected 
  def aws_start
    ec2 = AWS::EC2.new(
      :access_key_id => Figaro.env.aws_key_id,
      :secret_access_key => Figaro.env.aws_key_secret
    )

    request = ec2.client.request_spot_instances({
      :spot_price => "0.0075",  # youtu.be/M8KrUWeBt_s
      :instance_count => 1,
      :type => "one-time",
      :valid_from => DateTime.now,
      :valid_until => DateTime.now + 1/24, # wait up to an hour if neccesary
      :launch_specification => {
        :image_id => "ami-a18c8fc8",
        :instance_type => "m1.small",
      },
    })

    # wait until the instance has been requisitioned and booted
    loop do
      description = ec2.client.describe_spot_instance_requests({:spot_instance_request_ids => [request[:spot_instance_request_set][0][:spot_instance_request_id]]})
      if description[:spot_instance_request_set][0][:state] == 'active'
        return description[:spot_instance_request_set][0][:instance_id]
      elsif description[:spot_instance_request_set][0][:state] == "closed"
        return false
      end
    end

  end
  handle_asynchronously :aws_start

end
