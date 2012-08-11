# Activerecord::Confirmable

Railsで、controllerにconfirmアクションを作らずに、確認画面を実装するためのモジュールです。

## Installation

Add this line to your application's Gemfile:

    gem 'activerecord-confirmable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-confirmable

## Usage

このモジュールをモデルにincludeすると、confirmedアトリビュートが追加されます。フォームに、hidden_field :confirmed を追加すると確認画面に遷移するようになります。#confirmation? がtrueの場合はモデルが確認画面の状態なので、適切にviewを切り替えてください。

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
