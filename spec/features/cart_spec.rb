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

    expect(page).to have_selector('#cart', visible: false)

    within("#product_#{product2.id}") do
      click_button 'Add to Cart'
    end

    expect(page).to have_content("Product added to cart")
    expect(page).to have_css("#cart tr", :count => 2)

    within("#product_#{product2.id}") do
      click_button 'Add to Cart'
    end

    expect(page).to have_content("Product added to cart")
    expect(page).to have_css("#cart tr", :count => 2)

    expect(page).to have_content("Name")
    expect(page).to have_content("Quantity")
    expect(page).to have_content("Price")
    expect(page).to have_content("Total Price")

    expect(page).to have_content("Product #2")
    within('.quantity') do
      expect(page).to have_content("2")
    end
    expect(page).to have_content("$2.22")
    expect(page).to have_content("$4.44")
  end

  scenario "Visitor empties their cart" do
    visit "/"

    within("#product_#{product2.id}") do
      click_button 'Add to Cart'
    end

    within("table.cart") do
      expect(page).to have_content(product2.name)
    end

    click_button "Empty Cart"
    expect(page).to have_content("Your cart is currently empty")

    expect(page).to have_selector('#cart', visible: false)
  end
end