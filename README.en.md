# Activerecord::Confirmable

Confirmation view helper of model on creating or updating.

## Installation

Add this line to your application's Gemfile:

    gem 'activerecord-confirmable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-confirmable

## Usage

This module is adding by virtual confimed attribute to your model. #confirmation? method returns submittion status.


                         validation fail
          +---------------+-----------------------------+
          |               |                             |
          v               |                             |
    +--------------+    submit    +--------------+    submit
    |  new / edit  |  ----------> | confirmation |  ---------->  done
    +--------------+              +--------------+
    confirmed != '1'              confirmed == '1'

          ^                                |
          |  back (set confirmed = false)  |
          +--------------------------------+

exapmle:

    class Article
      include ActiveRecord::Confirmable
    end

    class ArticlesController
      def create
        @article = Article.new(params[:article])
        @article.confirmed = false if params[:commit] == "back"
        if @article.save
          redirect_to @article
        else
          render action: "new"
        end
      end

      def update
        @article = Article.find(params[:id])
        params[:article][:confirmed] = false if params[:commit] == "back"
        if @article.update_attributes(params[:article])
          redirect_to @article
        else
          render action: "edit"
        end
      end
    end

    articles/_form.html.erb
      <%= form_for(@article) do |f| %>
        <%= f.text_field :title %>
        <%= f.submit f.object.confirmation? ? "submit" : "confirm" %>
        <%= f.submit "back" if f.object.confirmation? %>
        <%= f.hidden_field :confirmed %>
      <% end %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
