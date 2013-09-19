require 'spec_helper'

describe Cart do
  subject { Cart.create }
  let(:product) { FactoryGirl.create(:product) }
  let(:product2) { FactoryGirl.create(:product) }

  it { should have_many(:line_items).dependent(:destroy) }

  describe ".total_quantity" do
    context "when we have two items in the cart" do
      it "adds up the quantity of each item" do
        2.times { subject.add_product(product.id) }
        subject.add_product(product2.id)
        expect(subject.total_quantity).to eq(3)
      end
    end
  end

  describe ".add_product(product_id)" do
    context "when the product has not been added before" do
      it "builds a line item with a default quantity of 1" do
        line_item = subject.add_product(product.id)
        expect(line_item.quantity).to eq(1)
      end
    end
    context "when the product has been added before" do
      before(:each) do
        subject.add_product(product.id).save
        subject.reload
      end
      it "updates the existing line_item by adding 1 to the quantity" do
        line_item = subject.add_product(product.id)
        expect(line_item.quantity).to eq(2)
      end
    end
  end
end
