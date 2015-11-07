require "rails_helper"

RSpec.feature "Visual regressions" do
  after(:each) do |example|
    Percy::Capybara.snapshot(page, name: example.full_description)
  end

  scenario "customer index" do
    create(:customer)
    visit admin_customers_path
  end

  scenario "searching interactions", :js do
    visit admin_customers_path
    fill_in(:search, with: "Test search")
    sleep 1
  end

  scenario "customer with order" do
    order = create(:order)
    visit admin_customer_path(order.customer)
  end

  scenario "customer edit page" do
    customer = create(:customer)
    visit edit_admin_customer_path(customer)
  end

  scenario "new customer page" do
    visit new_admin_customer_path
  end
end
