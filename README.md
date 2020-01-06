# Kisi Test Task  

The task is to build a background job processing system with Rails framework based on Google Pub Sub. This repo contains the code for the following  test objectives. 

### Challenge Objectives 
1. Transparent enqueueing with ActiveJob to Google Pub Sub
2. Background workers dequeue job params and execute the corresponding jobs
3. If a job fails, it should be retried at most two times at least five minutes apart (three tries in total, morgue queue)
4. Use ActiveSupport::Instrumentation to collect simple metrics

For details refer: [Kisi Backend Challenge](https://gist.github.com/ce07c3/e8048fc468eef503cbc78a21855aa139#file-kisi-backend-challenge-2019-md)








# Configuration  

### System Dependencies

- Ruby 2.4.0+ installed <br>
- Rails 4.2+ application <br>
- Google Cloud SDK installed <br>

Quickstart Setup: [For MacOS](https://cloud.google.com/sdk/docs/quickstart-macos)<br>
Pub/Sub Emulator Setup: [Installation](https://cloud.google.com/pubsub/docs/emulator)


### Set up the Project 

Copy the code to your local machine

`git clone https://github.com/gssankar/kisi_testtask.git`

Install dependencies by using bundler 

`bundle install`


### Authentication 

Execute the following command to authenticate `gcloud` via service account. *(.json key will be sent via email)*

`gcloud auth activate-service-account --key-file ../../k-project-262422-c2d00007856f.json` 

Run the following commands to set the variables. 

```
export PUBSUB_VERIFICATION_TOKEN=317cd18bdcb23523c
export PUBSUB_TOPIC=kisi_product
export GOOGLE_CLOUD_PROJECT=k-project-262422
```
Verify the project id and account, using `gcloud config list` 



### Deployment     

Run `rails server` and the UI should be dispalyed on http://localhost:3000/ 












# Code Workflow 

Application enqueues tasks to google pub/sub (job is placed in the queue). These tasks are pulled by the worker, which then executes the job.

### Use Case  

A simple kisi software subscription model is considered for this challenge. A publisher application sends message to a topic, which is then pulled by the subscribers. 

**Topic:** kisi_product <br>
**Subscribers:** kisi_basic, kisi_pro, etc





### Implementation Sequence 

1. **Publish Message:** Send message to the topic <br>
Open [localhost:4567](http://localhost:4567/) in a *new tab* to send message. This could also be done directly via Google Cloud Console. 

2. **Create Subscription:** Creates a new subscription (kisi_pro1). <br> 
Once the subscription is created, messages published to the topic are queued (when worker isnt online)<br>
Job is enqueued using perform_async <br>

3. **Start Worker:** When the worker comes online, pub/sub delivers any queued events. <br>
For the sake of implementation, the worker is modelled to take in a simple case attribute. When executed, the message is pulled with an acknowledgment response. <br>
The retry mechanism is configured with `sidekiq:options` (three retries in total, five minutes apart) <br>
(The above components when executed, will run external commands on seperate process.)  





### Metrics

**Job Dashboard:** 			Sidekiq (Job count, processed, duration, etc). Sidekiq’s API provides real-time information about worker, queues and jobs. 

**View Metrics:** 			Newrelick metrics (error code, etc). 



### Clean Up 

Command/ctrl+c will stop all the running processes 





## Notes   

Prior to this I didnt have much exposure on RoR or GCP, so I had to focus on the fundamentals. I learnt a ton on this assignment, most of it extremely basic. Below are some concepts that I explored: 

- Python pub/sub approach in GCP, that uses virtual environment
- Action mailer
- AppEngine deployment (flex)
- ActiveJob interface with Sidekiq 
- ActiveJob interface with Google pub/sub 

As much I've enjoyed working on this, I do realize there is so much room for improvements and I'd like to hear your feedback. 







