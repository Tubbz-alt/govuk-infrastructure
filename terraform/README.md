# Terraform for GOV.UK Publishing on ECS

## Directory structure

* `deployments`: root modules, from where you can run Terraform commands.
    * `govuk-test`: calls the `govuk` composition module to bring up the
      infrastructure (apart from updating ECS Service task definitions)
    * `apps`: called by the Concourse CD pipeline to create new task definition
      revisions during a deploy.
        * `test`
          * `publisher`: deployment module for creating a new task definition
            revision for the Publisher app in the `test` environment. Requires
            an `image_tag` variable.
          * ...
* `modules`: non-root modules
    * `govuk`: composition module for an entire GOV.UK Publishing environment
    * `app`: reusable module for an app; contains the essential resources which all the apps need.
    * `apps`: composition modules for each app; calls the app module plus any
      app-specific resources.
        * `publisher`: module which creates the Publisher app
        * ...
    * `task-definition`: reusable module for creating a task definition
    * `task-definitions`: task definitions for each app
        * `publisher`: module which creates a task definition for the Publisher app
