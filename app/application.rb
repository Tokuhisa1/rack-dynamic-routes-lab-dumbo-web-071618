class Application
  def call env
    req = Rack::Request.new env
    res = Rack::Response.new

    req.path.match(/items/) ? handle_items(req, res) : handle_errors(res)

    res.finish
  end

  def handle_items req, res
    item_name = req.path.split("/items/").last # Turn /items/item into item
    item = @@items.find { |item| item.name == item_name }

    @@items.include?(item) ? res.write(item.price) :
                            (res.write "Item not found"; res.status = 400)
  end

  def handle_errors res
    res.write "Route not found"
    res.status = 404
  end
end
