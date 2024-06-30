# JMeter Setup Guide for Dokku

This guide provides step-by-step instructions on how to set up JMeter on Dokku with all the necessary configurations.

## Creating the Dokku App

1. **Create the JMeter app on Dokku:**

   ```bash
   dokku apps:create jmeter
   ```
2. **Set the JMeter version and timezone:**

   ```bash
   dokku config:set jmeter JMETER_VERSION=5.6.3 TZ="Europe/Moscow"
   ```
3. **Create directories for JMeter storage:**

   ```bash
   mkdir -p /var/lib/dokku/data/storage/jmeter/tests
   ```

4. **Mount the storage directory to the Dokku app:**

   ```bash
   dokku storage:mount jmeter /var/lib/dokku/data/storage/jmeter/tests:/tests
   ```

5. **Configure user, ramp-up, and duration settings:**

   ```bash
   dokku config:set jmeter USERS=100 RAMPUP=1200 DURATION=1800
   ```

## Setting Specific Configurations 

For a specific setup, configure the following:

   ```bash
   dokku config:set jmeter URL_HOST="testing" SCHEME="https" URL_CORE="coretest.testing.io" URL_AUTH="authtest.testing.io" URL_PRESENCE="presencetest.testing.io"
   ```

## Preparing the Test Environment

   ### Copy the test script to the storage directory:
   Download and copy the test.sh script from the repository to /var/lib/dokku/data/storage/jmeter/tests. This script is essential for initializing test variables and other directory configurations.

## Deploying to Dokku

Finally, push your configurations to Dokku. You can follow a workflow example for deployment.

---

By following these steps, you will have JMeter set up on Dokku with custom configurations tailored to your testing environment.

---

# RESULTS WILL BE IN /var/lib/dokku/data/storage/jmeter/tests #