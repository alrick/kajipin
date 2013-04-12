class Filepicker < ActiveRecord::Base
  self.abstract_class = true
  
  include HTTParty # Used for http requests

  # Delete S3 file
  def delete_remote
    policy = get_policy("remove")
    signature = get_signature(policy)
    remote = url+"?signature="+signature+"&policy="+policy
    try = self.class.delete(remote)

    # If file not found in filepicker, destroy anyway, else only if success
    if try.not_found?
      true
    else
      try.success?
    end
  end

  private

  # Get filepicker policy
  def get_policy(call)
    if !["pick", "read", "stat", "write", "writeUrl", "store", "convert", "remove"].include? call
      raise "Incorrect call"
    else
      expiry = Time.now.to_i + 60*60
      json_policy = {:call => call, :handle => handle, :expiry => expiry}.to_json
      policy = Base64.urlsafe_encode64(json_policy)
    end
  end

  # Get filepicker signature
  def get_signature(policy)
    secret = ENV["FILEPICKER_SECRET"]
    signature = OpenSSL::HMAC.hexdigest("sha256", secret, policy)
  end
end