require 'rails_helper'

feature '404 page' do
  scenario 'render 404 for a non-existent username' do
    expect { visit 'thisshouldgivea404lalalalalababa' }.to raise_error(
      ActionController::RoutingError, 'Not Found'
    )
  end
end
