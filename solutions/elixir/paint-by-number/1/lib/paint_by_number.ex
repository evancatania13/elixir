defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    # Please implement the palette_bit_size/1 function
    do_palette_bit_size(Enum.to_list(1..color_count), color_count)
  end

  defp do_palette_bit_size(list, number) do
    [h | t] = list
    if 2 ** h  >= number do
      h
    else
      do_palette_bit_size(t, number)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end
  
  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<value::size(bit_size), rest::bitstring>> = picture
    value
  end
  
  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<value::size(bit_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
