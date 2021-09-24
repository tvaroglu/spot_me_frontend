<div align="center">

# [SpotMe](https://spotme-app.herokuapp.com/)
[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
[![Stargazers][stars-shield]][stars-url]
[![Forks][forks-shield]][forks-url]
<img src="https://img.shields.io/travis/tvaroglu/spot_me_frontend?style=flat-square">
<a href="https://github.com/tvaroglu/spot_me_backend"><img src="https://img.shields.io/static/v1?style=flat-square&label=Spot+Me&message=APIv1&color=9cf"></a>

<br>

<img src="https://user-images.githubusercontent.com/74567704/133356706-90e886e7-a9ec-4fbe-8b96-d876a9e08112.png" width="70%"><br/>

<br>

  Finding a gym buddy to help maintain motivation for a long-term fitness regimen can be a challenging (and sometimes awkward) task... enter SpotMe!

  SpotMe is a database-driven web application in which users can register with their gym(s) of choice, and find other registered users to share in their collective workout experience.

---

## Contributors

|Brian Fletcher|Caroline Tan|Ezzedine Alwafai|Gunnar Runkle|Scott Borecki|Taylor Varoglu
|--- |--- |--- |--- |--- |--- |
|[GitHub](https://github.com/bfl3tch)|[GitHub](https://github.com/carolinectan)|[GitHub](https://github.com/ealwafai)|[GitHub](https://github.com/gunnarrunner)|[GitHub](https://github.com/Scott-Borecki)|[GitHub](https://github.com/tvaroglu)
|[LinkedIn](https://www.linkedin.com/in/bfl3tch/)|[LinkedIn](https://www.linkedin.com/in/carolinectan/)|[LinkedIn](https://www.linkedin.com/in/ezzedine-alwafai/)|[LinkedIn](https://www.linkedin.com/in/gunnar-runkle/)|[LinkedIn](https://www.linkedin.com/in/scott-borecki/)|[LinkedIn](https://www.linkedin.com/in/taylorvaroglu/)


## Table of Contents
|Links
|--- |
[Tools Used](#tools-used)
[Setup](#setup)
[Learning Goals](#learning-goals)
[Database Schema](#database-schema)
[Wireframes](#wireframes)


## Tools Used

|Development|Development|Testing|Deployment
|--- |--- |--- |--- |
|[Ruby 2.7.2](https://www.ruby-lang.org/en/downloads/)|[Bootstrap](https://rubygems.org/gems/bootstrap/versions/4.0.0)|[RSpec for Rails](https://github.com/rspec/rspec-rails)|[Heroku](http://virtual-watch-party.herokuapp.com)|
|[Pry](https://rubygems.org/gems/pry/versions/0.10.3)|[Github](https://desktop.github.com/)|[Capybara](https://github.com/teamcapybara/capybara)|[Travis CI](https://travis-ci.org/)|
|[Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)|[Git](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)|[Webmock](https://github.com/bblimke/webmock)
|[PostgresQL](https://www.postgresql.org/)|[HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)|[VCR](https://github.com/vcr/vcr)
|[OmniAuth Google OAuth2](https://github.com/zquestz/omniauth-google-oauth2)|[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS)|[Launchy](https://rubygems.org/gems/launchy/versions/2.4.3)
|[Postico](https://eggerapps.at/postico/)|[Rubocop](https://rubygems.org/gems/rubocop/versions/0.39.0)|[Orderly](https://github.com/jmondo/orderly)
|[Faraday](https://github.com/lostisland/faraday)|[Atom](https://atom.io/)|[SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)
|[Figaro](https://github.com/laserlemon/figaro)|[FactoryBot](https://github.com/thoughtbot/factory_bot)
|[Postman](https://www.postman.com/product/rest-client/)|

</div>

<div align="center">

## Setup

</div>


  This project requires Ruby 2.7.2.

  * Fork this repository
  * From the command line, install gems and set up your DB:
      * `bundle`
      * `bundle update`
      * `rails db:{create,migrate}`
  * Run the test suite with `bundle exec rspec -fd`
  * Run your development server with `rails s` to see the app in action.

#### Project Configurations

  * Ruby version
      ```bash
      $ ruby -v
      ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
      ```

  * [System dependencies](https://github.com/tvaroglu/spot_me_frontend/blob/main/Gemfile)
      ```bash
      $ rails -v
      Rails 5.2.6
      ```

  * Database creation
      ```bash
      $ rails db:{drop,create,migrate,seed}
      Created database 'spot_me_frontend_development'
      Created database 'spot_me_frontend_test'
      ```

  * [OAuth setup](https://github.com/zquestz/omniauth-google-oauth2#installation)
      ```bash
      Add to your Gemfile:
        gem 'omniauth-google-oauth2'
      $ bundle install
      ```


  * [Google API setup](https://console.developers.google.com)
      ```bash
      Visit https://console.developers.google.com
      - Select your project
        - From the Credentials section:
          - Select the "OAuth consent screen" tab on top, and provide an 'EMAIL ADDRESS' and a 'PRODUCT NAME'
          - Wait 10 minutes for changes to take effect.
      ```

  * [Yelp API access](https://www.yelp.com/developers/documentation/v3/get_started)
      ```bash
      Visit https://www.yelp.com/developers/documentation/v3/get_started
      - Sign up for an account
      - To register for an API key, from within your account settings page:
        - Click on your avatar or initials in the main navigation
        - Click the "Settings" link
        - Click the "API" link in the left sidebar
        - Click "Create" or "click here" on the API page
      - This repo will be utilizing the `v3` token.
      ```

  * [API key configuration](https://github.com/laserlemon/figaro)
      ```bash
      $ gem install figaro
      $ bundle exec figaro install
      open the new hidden file application.yml
      set yelp_api_key: Bearer [your v4 token]
      ```

  * How to run the test suite
      ```bash
      $ bundle exec rspec -fd
      ```

  * [Local Deployment](http://localhost:3000), for testing
      ```bash
      $ rails s
      => Booting Puma
      => Rails 5.2.6 application starting in development
      => Run `rails server -h` for more startup options
      Puma starting in single mode...
      * Version 3.12.6 (ruby 2.7.2-p137), codename: Llamas in Pajamas
      * Min threads: 5, max threads: 5
      * Environment: development
      * Listening on tcp://localhost:3000
      Use Ctrl-C to stop
      ```

  * [Heroku Deployment](https://spotme-app.herokuapp.com/), for production


<div align="center">

## Learning Goals

</div>


&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Consume two or more external APIs which require authentication<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Build APIs that return JSON responses<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Use an external OAuth provider to authenticate users<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Create a project with a separate frontend and backend<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Organize and refactor code to be more maintainable<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Implement a self-referential relationship in ActiveRecord<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Utilize Continuous Integration using Travis CI<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Deploy to Heroku<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Implement a production-quality user interface using Bootstrap or other common CSS styling framework<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Implement project management by using project boards, participating in daily stand-ups and team retros<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Use Rails to create web pages that allow users to CRUD resources<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Utilize quality workflow practices: small commits, descriptive pull requests, and code reviews<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Write thorough, understandable documentation<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Create instance and class methods on a Rails model that use ActiveRecord methods and helpers<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Write model and feature tests that fully cover data logic and potential user behavior<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Apply RuboCop’s style guide for code quality<br>

<div align="center">

## Database Schema

<img src="https://user-images.githubusercontent.com/58891447/133720976-ad5a8517-f838-4455-be0a-8a80d9690495.png">

## Wireframes
[Home Page](#home-page) | [User Registration](#user-registration) | [User Dashboard](#user-dashboard) |
[User Profile #1](#user-profile-no-1) | [User Profile #2](#user-profile-no-2) |
[User Profile #3](#user-profile-no-3) | [Edit Profile](#edit-profile) | [Gym Index](#gym-index) |
[Gym Show Page #1](#gym-show-page-no-1) | [Gym Show Page #2](#gym-show-page-no-2) |
[New Event Page](#new-event-page)

The following section displays a comparison of our vision and how our vision came to life.


### Home Page


<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133532325-f08a0ca3-f5c9-4b86-b61d-1ec8c8c9f344.png" width: 50%>
  </td>

  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133532325-f08a0ca3-f5c9-4b86-b61d-1ec8c8c9f344.png" width: 50%>
  </td>
</tr>
</table>


### User Registration

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/58891447/133721192-c6a81764-df2c-4b19-b4eb-f8836c03476d.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/58891447/133721192-c6a81764-df2c-4b19-b4eb-f8836c03476d.png" width: 50%>
  </td>
</tr>
</table>

### User Dashboard

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133532151-d283fc77-9ebf-4aae-a322-e8406f8e65ae.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133532151-d283fc77-9ebf-4aae-a322-e8406f8e65ae.png" width: 50%>
  </td>
</tr>
</table>

### User Profile No. 1
When you visit your own profile

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133531830-9763122d-137b-4017-bcae-9d9e47a659c4.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133531830-9763122d-137b-4017-bcae-9d9e47a659c4.png" width: 50%>
  </td>
</tr>
</table>

#### User Profile No. 2
When you visit the profile of as user you follow.

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133531844-cce0428e-1364-44a0-bfee-335f7b36a2f0.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133531844-cce0428e-1364-44a0-bfee-335f7b36a2f0.png" width: 50%>
  </td>
</tr>
</table>

#### User Profile No. 3
When you visit the profile of as user you do not follow.

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133534573-8121a93a-df87-4e29-9eab-0d9a2b9c5483.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133534573-8121a93a-df87-4e29-9eab-0d9a2b9c5483.png" width: 50%>
  </td>
</tr>
</table>

### Edit Profile

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133537369-0536181e-7b14-4bfe-9293-bbee83b37f44.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133537369-0536181e-7b14-4bfe-9293-bbee83b37f44.png" width: 50%>
  </td>
</tr>
</table>

### Gym Index

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133538049-855f5c24-8d2c-473b-941b-ff6d2bbcd159.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133538049-855f5c24-8d2c-473b-941b-ff6d2bbcd159.png" width: 50%>
  </td>
</tr>
</table>

### Gym Show Page No. 1
When you are not a member of the gym.

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133537174-25ea5948-f7a6-4d9d-841b-126ea05af8a3.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133537174-25ea5948-f7a6-4d9d-841b-126ea05af8a3.png" width: 50%>
  </td>
</tr>
</table>

### Gym Show Page No. 2
When you are a member of the gym.

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133537305-c4bb086a-6e85-45bb-a495-b5bdab04dd90.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133537305-c4bb086a-6e85-45bb-a495-b5bdab04dd90.png" width: 50%>
  </td>
</tr>
</table>

### New Event Page

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr>
  <td>  
    <img src="https://user-images.githubusercontent.com/74567704/133538160-2303a2ef-ffa3-41bc-aa9f-e0d6c44ca7a1.png" width: 50%>
  </td>
  <td>
    <img src="https://user-images.githubusercontent.com/74567704/133538160-2303a2ef-ffa3-41bc-aa9f-e0d6c44ca7a1.png" width: 50%>
  </td>
</tr>
</table>

</div>

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/tvaroglu/spot_me_frontend.svg?style=flat-square
[contributors-url]: https://github.com/tvaroglu/spot_me_frontend/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/tvaroglu/spot_me_frontend.svg?style=flat-square
[forks-url]: https://github.com/tvaroglu/spot_me_frontend/network/members
[stars-shield]: https://img.shields.io/github/stars/tvaroglu/spot_me_frontend.svg?style=flat-square
[stars-url]: https://github.com/tvaroglu/spot_me_frontend/stargazers
[issues-shield]: https://img.shields.io/github/issues/tvaroglu/spot_me_frontend.svg?style=flat-square
[issues-url]: https://github.com/tvaroglu/spot_me_frontend/issues
