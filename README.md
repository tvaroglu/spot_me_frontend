<div align="center">

# [SpotMe](https://spotme-app.herokuapp.com/)
[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
[![Stargazers][stars-shield]][stars-url]
[![Forks][forks-shield]][forks-url]
![Build Badge][build-badge]
<a href="https://github.com/tvaroglu/spot_me_backend"><img src="https://img.shields.io/static/v1?style=flat-square&label=Spot+Me&message=APIv1&color=9cf"></a>

<br>

<img src="https://user-images.githubusercontent.com/77654906/134606173-65c4cfaa-a7c9-46b4-9e4d-560989f9ec8c.png" width="100%"><br/>

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
      $ bundle exec figaro install
      ```
      Add your API key to `config/application.yml`:
      ```yml
      yelp_api_key: 'Bearer <your v4 token>'
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

<img src="https://user-images.githubusercontent.com/77654906/134606405-5b314780-d1ed-48ac-8337-43f01e7c129e.png">

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

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134611529-ee566f26-c37a-40a0-a085-37fbe6e2047a.png" style="height:200px">
  </td>

  <td style = 'width:45%'>
    <img src="https://user-images.githubusercontent.com/77654906/134611661-b627cf0e-618e-4ea7-8227-591f8a58934a.png" style="height:200px">
  </td>
</tr>
</table>


### User Registration

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>
    <img src="https://user-images.githubusercontent.com/77654906/134607507-63b9ab1a-c6ba-4065-914c-7c6aff1cc3c7.png" style="height:200px">
  </td>
  <td style = 'width:45%'>
    <img src="https://user-images.githubusercontent.com/77654906/134611060-aa275111-6c36-4cfe-a05a-155c6474c8dc.png" style="height:200px">
  </td>
</tr>
</table>

### User Dashboard

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134607569-50fb42c1-2361-4f72-8f93-2204e63fba9f.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134611300-cdfa5f95-2d3f-460f-9765-210fd783598a.png" style="height:200px">
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

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134607641-450aa4ea-2deb-4ae8-ae66-bd124b0c64ff.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134685865-5c38fb57-30bb-427e-86f7-74a39ca2339d.png" style="height:200px">
  </td>
</tr>
</table>

#### User Profile No. 2
When you visit the profile of a user you follow

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134607730-1497a446-dba2-4759-92bc-1d91bc3120f3.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134688744-c81d6347-4d54-4c5c-9543-288d3f76c2a1.png" style="height:200px">
  </td>
</tr>
</table>

#### User Profile No. 3
When you visit the profile of a user you do not follow

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134607784-46b4bfb3-c68a-4369-a9e7-e90ee35a9b51.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134685011-94e18d9f-2e60-4911-bb03-9196bc8d57a4.png" style="height:200px">
  </td>
</tr>
</table>

### Edit Profile

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134609165-8ee83942-3411-4664-a80e-8091afe88300.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134687195-73906d6c-8377-4c22-b59d-e7af281381d6.png" style="height:200px">
  </td>
</tr>
</table>

### Gym Index

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134607849-9990b284-5624-4665-8c94-e31be71f5f1c.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134686403-c8ecca65-b1c5-482d-b6c1-277f42c9e39d.png" style="height:200px">
  </td>
</tr>
</table>

### Gym Show Page No. 1
When you are not a member of the gym

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134607940-77263a9c-5619-4b15-811f-f1dd2a685a88.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134686841-830dcb13-8f85-4a1e-ba46-3d2ea085d6a1.png" style="height:200px">
  </td>
</tr>
</table>

### Gym Show Page No. 2
When you are a member of the gym

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134608630-a4574498-e543-4368-a9b7-120443d9a56d.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134685377-23a5d15f-1d56-4d7e-bd26-a08da8479927.png" style="height:200px">
  </td>
</tr>
</table>

### New Event Page

<table>
<tr>
  <th style='text-align: center'>Wireframe</th>
  <th style='text-align: center'>Production</th>
</tr>

<tr align = 'center'>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/77654906/134608670-0e265185-1d2f-4dcc-8e61-21b012ab46de.png" style="height:200px">
  </td>
  <td style = 'width:45%'>  
    <img src="https://user-images.githubusercontent.com/79381792/134689936-4ea9fa1f-0c75-4dd2-a389-faf389250aa7.png" style="height:200px">
  </td>
</tr>
</table>

</div>

## Acknowledgements

- Background Image: https://unsplash.com/photos/20jX9b35r_M
- SVG Icons: https://linea.io/
  - Linea Iconset is a free iconset designed by Dario Ferrando.

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/tvaroglu/spot_me_frontend.svg?style=flat-square
[contributors-url]: https://github.com/tvaroglu/spot_me_frontend/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/tvaroglu/spot_me_frontend.svg?style=flat-square
[forks-url]: https://github.com/tvaroglu/spot_me_frontend/network/members
[stars-shield]: https://img.shields.io/github/stars/tvaroglu/spot_me_frontend.svg?style=flat-square
[stars-url]: https://github.com/tvaroglu/spot_me_frontend/stargazers
[issues-shield]: https://img.shields.io/github/issues/tvaroglu/spot_me_frontend.svg?style=flat-square
[issues-url]: https://github.com/tvaroglu/spot_me_frontend/issues
[build-badge]: https://img.shields.io/circleci/build/github/tvaroglu/spot_me_frontend?style=flat-square
