module CategoriesHelper
  def format_image(name_image)
    arr = name_image.split("|")
    name = arr[0]
    image = arr[1]
    "#{name}" + " " + tag("img", src: image)
  end
end


