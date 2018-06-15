module DropboxApi::Endpoints
  module OptionsBuilder
    def build_write_mode_param(write_mode)
      case write_mode
      when String, Symbol
        DropboxApi::Metadata::WriteMode.new write_mode
      when DropboxApi::Metadata::WriteMode
        write_mode
      else
        raise ArgumentError, "Invalid write mode: #{write_mode.inspect}"
      end.to_hash
    end
  end
end
