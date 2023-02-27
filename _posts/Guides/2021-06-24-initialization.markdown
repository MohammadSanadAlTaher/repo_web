---
layout: post
title:  "Initialization"
date:   2021-06-24 00:17:08 +0300
author: "Sanad"
permalink: /guides/initialization/
---


<script type="text/javascript">
window.onload = function(){
    alert("Guide is currently incomplete.");
    }
</script>

Here, I will detail [**how**](#how) and [**why**](#why) I built this site for those who are interested in building one for themselves.

<p>&nbsp;</p>

# How?

As a student, using open-source/freeware was a priority. At the time of writing this post (June 24th 2021), I have not paid a single cent for this website, and I am only expecting to pay to renew my domain registration (~20USD/year).

Unless major changes have been made to the services I used, you should be able to create a completely free website by following the steps outlined below.

As always, feel free to [reach out]({% link zcontact.md %}) if any issues linger. 

_**Note:** you don't need to follow the exact order of the steps, however, this is the order I followed._ 

<p>&nbsp;</p>

## Steps:

###   Setup:

1. **Make a [GitHub](https://github.com/) account:**
    
    Having a GitHub account was essential to me because I chose to host my website on [GitHub Pages](https://pages.github.com/), which is a free hosting service for **static** sites. 
   
2. **Registering a domain:**
   
    Another reason why a GitHub account is essential is that if you sign up to GitHub with a student email address (i.e., the email address provided by your institution), you can register a free .me domain for a year on [namecheap](https://www.namecheap.com/).
    
    **To access all GitHub student benefits (including the free .me domain registration), [click here](https://education.github.com/pack).**
    
    Mentioning the steps for registering a domain is redundant, as they are easy to follow and are outlined by namecheap or any other domain registry service you choose to use.

3. **Access your domain:**
    
    If you've registered your domain to your GitHub account successfully, then going on your domain should show your GitHub username.
   
4. **Register for cloudflare:**

    I found that [cloudflare](http://cloudflare.com/) DNS was the most suitable for me. Hence, my next step was to sign up to cloudflare and put my domain on their [Free Plan](https://www.cloudflare.com/en-gb/plans/free/).

    To setup the DNS records and add cloudflare's servers, I followed [this guide](https://www.namecheap.com/support/knowledgebase/article.aspx/9607/2210/how-to-set-up-dns-records-for-your-domain-in-cloudflare-account/) by namecheap.

<p>&nbsp;</p>

#### Interlude 1:

Now that you've registered for all necessary services, the next steps will be downloading and installing software.

To generate this website, I decided to use [Jekyll](https://jekyllrb.com/), which is a simple open-source static site generator generally used for blogs and the such.

As mentioned earlier, GitHub Pages host **static sites only**, therefore, WordPress or other similar services will not be compatible, as they require a server running a script simultaneously (i.e., WordPress sites are dynamic). In addition, Jekyll integrates really well with GitHub Pages.

For the IDE, I'm using _WebStorm_ from [JetBrains](https://www.jetbrains.com/). (Please refer to step 7)

<p>&nbsp;</p>

###   Download & Installation:

{:start="5"}
5. **Download Jekyll:**
    
    Since Jekyll is a Ruby gem, we must download and install a _Ruby gems package manager_. If you don't have the Ruby programming language installed on your computer, you must download it as well.
   
    Frankly, this part required the most troubleshooting when I was creating this site. Hopefully it works right away for you!  

    To start, open [this link](https://rubyinstaller.org/downloads/) and download the recommended installer, which will be clearly highlighted. If you don't have Ruby preinstalled, make sure the installer you're downloading comes with a Devkit.

    I kept facing an issue where the installer would only install one gem, until I moved the download path and installation path to a folder with no spaces or special characters in its folderpath (e.g., C:\RubyJekyll). Thus, I would recommend downloading and installing in a plain text folder directly in the C drive.

    After the download is complete, launch the installer, accept the licence, **check** "Add Ruby executables to you PATH" and "Associate .rb and .rbw files with this Ruby installation". After the installation is complete, **check** "run 'ridk install' to install MSYS2 .....", then click "Finish".

   If Ruby has been installed successfully, a window similar to that shown in the picture below should appear.

   ![RubyInstall](/assets/img/RubyInstall.png){:height="232px" width="700px"}   

   Simply type 1, and wait for MSYS2 base installation to finish. After that, install the MSYS2 and MINGW development toolchain by entering 3.
    
   Once complete, launch Command Prompt and proceed to the next step


6. **Install Jekyll:**
   
   In cmd, type the following code to make sure Ruby has been successfully installed:
   
      
         ruby -v
   
   If the Ruby version is returned, proceed by typing:
   
         gem -v

   If a number is returned, proceed by typing:

         gem install jekyll bundler

   Then wait for it to finish installing.
   
   Once the installation is complete, make sure that the number of gems installed is at least 2, as shown in the picture below. 

   ![JekyllInstall](/assets/img/JekyllInstall.png){:height="188px" width="700px"}
   
    

7. **Choose a text editor:**
   
    **Note:** before proceeding, you may need to reboot your computer.  

    [WebStorm](https://www.jetbrains.com/webstorm/) is the ideal IDE for me. One of the advantages of using JetBrains software is you can easily apply for an education license from [here](https://www.jetbrains.com/community/education/#students), just be sure to use your student email, again.
    Since we are using Jekyll, the IDE will mainly be used for its text editor and syntax checker, integrated terminal, and file organization.
   
    If you decide to use WebStorm, make sure the terminal it's using is cmd by pressing Ctrl+Alt+S, select tools then terminal, now confirm that the Shell path directs to cmd.exe.
   
   To make sure everything is working run the 

         jekyll -v
   
   Command once again in the IDE's terminal and confirm that it returns the Jekyll version.


8. **Create a folder for your site and serve:**

   All that's left in this part is to create a folder for your site data to be stored in.

         jekyll new folder_name
   
   A new folder should have been created in C:\Users\current_user\ with a few default files.

   Next, change the terminal to the folder's directory by entering 

          C:\users\user_name\folder_namer

   in the terminal.

   Finally, you can serve your site by typing 

         bundle exec jekyll serve

   Which will start a site on port 4000 of your localhost (i.e., **http://127.0.0.1:4000/** should be returned in the terminal), then you can access the default website from any browser.


    
   **Note:**
   Before serving your site for the first time, you may need to run 

         bundle install

   Also, after serving your site for the first time, you can simply enter

         jekyll serve

   To server any changes you made or otherwise.


<p>&nbsp;</p>

#### Interlude 2:

Now that you've generated your static site, the next steps will cover the basics of editing the local site.

Please note that I will not cover text formatting. For its simplicity, I generally use markdown for writing posts. Markdown is a text-to-HTML conversion tool. Basic text formatting with markdown can be found [here](https://www.markdownguide.org/basic-syntax/).

Additionally, I found that markdown is quite beginner-friendly and, in a way, incentivizes users to learn basic HTML since it can easily be used in markdown files, as I will show in step n.

<p>&nbsp;</p>

###   Editing a local site:

{:start="9"}
9. **Front matter**

   permalinks, layouts, defaults, etc

10. **Creating posts:**


11. **Creating pages:**

      pages.md files

12. **Changing page structure:**

      changing

13. **Themes**
    
    As for the theme, I chose to stick to the default theme (_minima_). If you wish to change the theme, you may search for different themes [here](https://rubygems.org/) by typing

      > jekyll-theme

    After clicking on a theme, you can navigate to _links_, and click on _homepage_. Scroll down the git repository and find the preview link. Once you find a theme you like, copy its name, which will be similar to
    
      >jekyll-theme-[name]
    
    Next, open your Gemfile and add 
    
         gem "jekyll-theme-[name]"

      beneath the _minima_ line.
    Now you must install the theme by running the

         bundle install

      command in your terminal.
    
      Once the theme is installed, paste your theme's name in place of _minima_ in your _config.yml file, the theme line should be similar to 
         
         theme: jekyll-theme-[name]

      Finally, run the 

         bundle exec jekyll serve

      command in the terminal and your site should be using the new theme so long as you're using compatible layouts.

14. **General HTML:**

      Adding objects: pdfs, etc.
 

<p>&nbsp;</p>

#### Interlude 3:

<p>&nbsp;</p>

###   Moving your site to your public domain:

{:start="15"}
15. **Create a GitHub repository for your site:**


16. **Changing your static site's URL:**


17. **Pushing your site to your GitHub repository:**


18. **Applying any new changes:**

<p>&nbsp;</p>

## Conclusion:




Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk] or you can [contact]({% link zcontact.md %}) me personally.

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/



<p>&nbsp;</p>
----
----
<p>&nbsp;</p>


# Why?

The core reason for why I built this site is I wanted to learn a new skill. However, the reasons listed below were motives as well.

####   Reasons:
- Allows me to easily access my work.
- Allows students easy access to my work.
- Showcases my work to prospective employers or colleagues.

There are many other reasons, but these are the main ones I considered.

<p style="color:seagreen"><em>It's my belief that a person who has acquired knowledge has a duty to push forth that knowledge and reduce the barriers of gaining it for others.</em></p>




<style>


.plaintext {
    background: transparent;
    font-family: monospace;
    word-wrap: break-word;
}


</style>




