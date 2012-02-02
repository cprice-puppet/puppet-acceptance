module Windows::File
  include CommandFactory

  # TODO: a little of this could potentially be refactored out into a common base module for Files
  @base_tmp_dir = nil;

  def tmpfile(name)
    execute("cygpath -m $(mktemp --tmpdir=#{base_tmpdir} -t #{name}.XXXXXX)")
  end

  def tmpdir(name)
    execute("cygpath -m $(mktemp --tmpdir=#{base_tmpdir} -td #{name}.XXXXXX)")
  end

  # Create a directory structure on the remote hosts.
  # Parameters:
  # [path] the target directory to create; this method will attempt to create any missing parent directories as well
  def mkdirs(path)
    raise NotImplementedError.new
  end

  # Remove (recursively) a directory structure on the remote hosts.
  # Parameters:
  # [dir] the target directory to remove; this method will attempt to recursively delete all of the contents of the
  #       specified directory
  def rm_rf(path)
    execute("rm -rf #{path}")
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




  # private utility method to get the base temp dir path; the goal here is to quarantine acceptance test temp files into
  # one easily-identifiable directory that can be cleaned up easily
  def base_tmpdir()
    unless @base_tmp_dir then
      @base_tmp_dir = "#{get_system_tmpdir}/puppet-acceptance"
      mkdirs(@base_tmp_dir)
    end
    @base_tmp_dir
  end
  private :base_tmpdir

  # private utility method for determining the system tempdir
  def get_system_tmpdir()
    # hard-coded for now, but this could execute a command on the system to check environment variables, etc.
    "/tmp"
  end
  private :get_system_tmpdir

end
