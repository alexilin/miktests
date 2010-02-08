require 'fileutils'

module Uploads

  PUBLIC_ROOT  = "#{RAILS_ROOT}/public"
  PRIVATE_ROOT = "#{RAILS_ROOT}/private"
  DEFAULT_UPLOADS_DIR = "uploads"

  def make_uniq_path(abs_dir, file_path)
    desired_file_path = file_path
    i = 0
    while File.exists? file_path
      i += 1
      new_file_name = File.basename(desired_file_path, File.extname(file_path))
      new_file_name << "_#{i}" + File.extname(file_path)
      file_path = File.join(abs_dir, new_file_name)
    end
    return file_path
  end

  def save_uploaded_file file, options = {}
    raise "invalid uploaded file" if !file.original_filename

    dir = options[:to] || DEFAULT_UPLOADS_DIR
    abs_dir = File.join(options[:private] ? PRIVATE_ROOT : PUBLIC_ROOT, dir)

    file_path = File.join(abs_dir, file.original_filename)
    file_path = make_uniq_path(abs_dir, file_path)
    save_file(file, file_path)
    File.join(dir, File.basename(file_path))
  end

  def move_uploaded_file file, options = {}
    return if file.blank?
    dir = options[:to] || DEFAULT_UPLOADS_DIR
    abs_dir = File.join(options[:private] ? PRIVATE_ROOT : PUBLIC_ROOT, dir)
    src_file_path = "#{PRIVATE_ROOT}/#{file}"
    dest_file_path = make_uniq_path(abs_dir, src_file_path)
    FileUtils.mkpath File.dirname(dest_file_path)
    FileUtils.mv src_file_path, dest_file_path, :force => true
    File.join dir, File.basename(dest_file_path)
  end

  def remove_uploaded_file file, options = {}
    return if file.blank?
    root = options[:private] ? PRIVATE_ROOT : PUBLIC_ROOT
    FileUtils.remove_file File.join(root, file), true
  end

  def save_file file, dest_file_path
    FileUtils.mkpath File.dirname(dest_file_path)
    if file.class == String
      FileUtils.copy_file file, dest_file_path
    elsif file.local_path
      FileUtils.copy_file file.local_path, dest_file_path
    else
      write_file dest_file_path, file
    end
    dest_file_path
  end

  def write_file(dest, src)
    f = File.new dest, "wb"
    f.write src.read
    f.close
  end
end