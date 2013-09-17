require 'spec_helper'

feature "Cart" do
  let!(:product1) {
    Product.create(
        name: "Product #1",
        description: "This is Product #1",
        image_url: "product1.png",
        price: 1.11
    )
  }
  let!(:product2) {
    Product.create(
        name: "Product #2",
        description: "This is Product #2",
        image_url: "product2.png",
        price: 2.22
    )
  }

  scenario "Visitor views list of products" do

    visit "/"

    within("#product_#{product2.id}") do
      click_button 'Add to Cart'
    end

    expect(page).to have_content("Product added to cart")
    expect(page).to have_content("View Cart (1 item)")

    within("#product_#{product2.id}") do
      click_button 'Add to Cart'
    end

    expect(page).to have_content("Product added to cart")
    expect(page).to have_content("View Cart (2 items)")

    click_link "View Cart (2 items)"
    expect(page).to have_content(product2.name)
  end
end