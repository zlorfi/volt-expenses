# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController

    model :store

    # before_action do
    #   require_login('Please log in.')
    # end

    def index
      # self.model = store._expenses.order(amount: :asc)
      self.model = store._expenses.order(:amount)
    end

    private

    # Save the post
    def add_expense
      store
        ._expenses
        .create(description: page._new_description, amount: page._new_amount, created_at: Time.now, category: page._category)
        .then { page._new_description = '' }
        .then { page._new_amount = '' }
        .fail { |err| add_error(err) }
        # .fail { |err| flash._errors << err.to_s}
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
