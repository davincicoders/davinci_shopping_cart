require 'spec_helper'

describe Cart do
  it { should have_many(:line_items).dependent(:destroy) }

  describe ".add_product(product_id)" do
    subject { Cart.create }
    let(:product) { FactoryGirl.create(:product) }
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
