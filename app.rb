###### This file is part of Pub/sub 

require "sinatra"
require "slim"
require "json"
require "base64"
require "google/cloud/pubsub"

pubsub = Google::Cloud::Pubsub.new

# [START gae_flex_pubsub_env]
topic = pubsub.topic ENV["PUBSUB_TOPIC"]
PUBSUB_VERIFICATION_TOKEN = ENV["PUBSUB_VERIFICATION_TOKEN"]
# export GOOGLE_APPLICATION_CREDENTIALS=/Users/GokulSreram/Downloads/k-project-262422-c2d00007856f.json
# [END gae_flex_pubsub_env]





# [START gae_flex_pubsub_messages]
# List of all messages received by this instance
messages = []
# [END gae_flex_pubsub_messages]




# [START gae_flex_pubsub_index]
get "/" do
  @messages = messages

  slim :index
end

post "/publish" do
  topic.publish params[:payload]

  redirect "/", 303
end
# [END gae_flex_pubsub_index]




# [START gae_flex_pubsub_push]
post "/pubsub/push" do
  halt 400 if params[:token] != PUBSUB_VERIFICATION_TOKEN

  message = JSON.parse request.body.read
  payload = Base64.decode64 message["message"]["data"]

  messages.push payload
end
# [END gae_flex_pubsub_push]





__END__




@@index
doctype html
html
  head
    title Pub/Sub Ruby on Google App Engine Managed VMs
  body
    p Messages received by this instance:
    ul
      - @messages.each do |message|
        li = message

    form method="post" action="publish"
      textarea name="payload" placeholder="Enter message here"
      input type="submit" value="Publish" 
