module Windows::File
  include CommandFactory

  def tmpfile(name)
    execute("cygpath -m $(mktemp -t #{name}.XXXXXX)")
  end

  def tmpdir(name)
    execute("cygpath -m $(mktemp -td #{name}.XXXXXX)")
  end


  # Create a directory structure on the remote hosts.
  # Parameters:
  # [path] the target directory to create; this method will attempt to create any missing parent directories as well
  def mkdirs(path)
    raise NotImplementedError.new
  end

  def chown(owner, group, path)
    raise NotImplementedError.new
  end

  def chmod(mode, path)
    raise NotImplementedError.new
  end

  
  # Check to see if a file exists on a host
  # Parameters:
  # [file_path] the absolute path of a file to look for
  #
  # returns true if the file exists, false otherwise
  def file_exists?(file_path)
    raise NotImplementedError.new
  end
  
  

  def path_split(paths)
    paths.split(';')
  end
end
