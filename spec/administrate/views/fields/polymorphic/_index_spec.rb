require "rails_helper"

describe "fields/polymorphic/_index", type: :view do
  context "without an associated records" do
    it "displays nothing" do
      polymorphic = double(data: nil)

      render(
        partial: "fields/polymorphic/index.html.erb",
        locals: { field: polymorphic },
      )

      expect(rendered.strip).to eq("")
    end
  end

  context "with an associated record" do
    it "renders a link to the record" do
      product = create(:product)
      polymorphic = double(data: product, associated_resource: product.name)
      product_path = polymorphic_path([:admin, product])

      render(
        partial: "fields/polymorphic/index.html.erb",
        locals: { field: polymorphic },
      )

      expected = "<a href=\"#{product_path}\">#{product.name}</a>"
      expect(rendered.strip).to eq(expected)
    end
  end
end
