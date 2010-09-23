module AttachmentsHelper

  #from http://www.ruby-forum.com/topic/126876

  GIGA_SIZE = 1073741824.0
  MEGA_SIZE = 1048576.0
  KILO_SIZE = 1024.0

  # Return the file size with a readable style.
  def readable_file_size(size, precision)
    case
      when size == 1 : "1 Byte"
      when size < KILO_SIZE : "%d bytes" % size
      when size < MEGA_SIZE : "%.#{precision}f kb" % (size / KILO_SIZE)
      when size < GIGA_SIZE : "%.#{precision}f mb" % (size / MEGA_SIZE)
      else "%.#{precision}f gb" % (size / GIGA_SIZE)
    end
  end

end
