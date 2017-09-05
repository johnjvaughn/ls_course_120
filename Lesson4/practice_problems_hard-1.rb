class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

class SecretFile
  def initialize(secret_data, security_logger)
    @data = secret_data
    @security_logger = security_logger
  end

  def data
    @security_logger.create_log_entry
    @data
  end
end

