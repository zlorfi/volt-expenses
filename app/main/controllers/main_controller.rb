# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController

    model :store

    # def index
    # end

    private

    # def index_ready
    #   if RUBY_PLATFORM == 'opal'
    #     `$(#{first_element}).find('#category:first').selectize({create: true, sortField: 'text'});`
    #   end
    # end

    # Save the post
    def add_expense
      store
        ._expenses
        .create(description: page._new_description, amount: page._new_amount, created_at: Time.now, category_id: page._category_id)
        .then { page._new_description = '' }
        .then { page._new_amount = '' }
        .then { page._category_id = '' }
        .fail { |err| add_error(err) }
    end

    def add_error(error)
      error.each{|k, v| flash._errors.create "#{k}: #{v.join('.')}"}
    end

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
