# ## RubyMotion

# imageData = UIImage.UIImageJPEGRepresentation(@image_view.image, 1)
# encodedData = [imageData].pack("m0")
# data["image"] = encodedData
# BW::HTTP.post("http://localhost:3000/upload}", {payload: data}) do |response|
#   if response.ok?
#    end
# end


# ## Rails backend
# if params["image"]
#   unpack = params["image"].unpack("m0")
#   File.open("/tmp/image.jpg", "w+b") do |f|
#     f.write(unpack.first)
#   end
# end