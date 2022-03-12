# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'shows a basic welcome page' do
    visit '/'

    expect(page).to have_text('Hello World')
  end
end
