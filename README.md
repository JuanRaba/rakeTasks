# README

* Deployment instructions
    download
    rail db:create
    rails db:migrate

* Services
    If using async task will need redis, start running "sidekiq"

* Rake task (choose one)
    1) Asyncronous:     rake mytasks:jobrunner
    2) Syncronous:      rake mytasks:sample
    Notice: Use [] if want to use personal api i.e: rake mytasks:sample["https://demo#####.mockable.io"]

* How to run the test suite
    rails test -b test/models/engineer_test.rb
