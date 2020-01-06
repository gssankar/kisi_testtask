require "sinatra"
require "slim"
require "json"
require "base64"
require "google/cloud/pubsub"

pubsub = Google::Cloud::Pubsub.new

# pubsub_env
topic = pubsub.topic ENV["PUBSUB_TOPIC"]
PUBSUB_VERIFICATION_TOKEN = ENV["PUBSUB_VERIFICATION_TOKEN"]
# export GOOGLE_APPLICATION_CREDENTIALS=/Users/GokulSreram/Downloads/k-project-262422-c2d00007856f.json



# List of all messages received by this instance
messages = []


# pubsub_index
get "/" do
  @messages = messages

  slim :index
end

post "/publish" do
  topic.publish params[:payload]

  redirect "/", 303
end




# pubsub_push
post "/pubsub/push" do
  halt 400 if params[:token] != PUBSUB_VERIFICATION_TOKEN

  message = JSON.parse request.body.read
  payload = Base64.decode64 message["message"]["data"]

  messages.push payload
end



__END__


@@index
doctype html
html
  head
    title Pub/Sub 
  body
    p Messages received by this instance:
    ul
      - @messages.each do |message|
        li = message

    form method="post" action="publish"
      textarea name="payload" placeholder="Enter message here"
      input type="submit" value="Publish" 
