+++
categories = ["reference", "tutorial"]
date = "2017-10-29T11:18:47-04:00"
description = "Stryke Force 2767 instructions for ssh access to roboRIO"
draft = false
tags = ["frc"]
title = "SSH Setup for 2767"
weight = 0
+++

These are instructions for the 2767 team on how to configure easy SSH access to the roboRIO from macOS or Linux. (PuTTY instructions coming...)

## Linux and macOS
In the steps below, `$` is the command-line prompt and should not be typed when entering commands. **Grab a mentor for a walk-through of these instructions if you need help!**

1. Verify you have a `$HOME/.ssh` directory and that it has permission of `drwx------`. If so, skip the next step.
1. If you need to create `$HOME/.ssh`:

    ```sh
    $ mkdir ~/.ssh
    $ chmod 700 ~/.ssh
    ```

3. Go to your `$HOME/.ssh` directory and create a SSH key-pair for our roboRIOs:

    ```sh
    $ cd ~/.ssh
    $ ssh-keygen -C "YOUR FULL NAME" -f roborio-2767 # hit enter to skip password
    ```

    This will create a `roborio-2767` secret key and a `roborio-2767.pub` public key in `$HOME/.ssh`. Send the `roborio-2767.pub` file you created above to a mentor in a Slack DM. They will install it on our roboRIOs for you.

4. While still in your `$HOME/.ssh` directory, edit or create `$HOME/.ssh/config` and add the following:

    ```
    Host roborio
      identityfile ~/.ssh/roborio-2767
      userknownhostsfile /dev/null
      user admin
      loglevel QUIET
      stricthostkeychecking no
      hostname 10.27.67.2
    ```

5. As soon as your public key is installed on our roboRIOs, you will be able to log on or deploy to them without a password prompt or host key mismatch errors.
