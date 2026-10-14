{ ... }:

{
  services.searx = {
    enable = true;

    environmentFile = "/var/lib/searx/secret.env";

    settings = {
      general = {
        debug = false;
        instance_name = "SearXNG";
      };

      search = {
        safe_search = 0;
        autocomplete = "duckduckgo";
      };

      server = {
        bind_address = "127.0.0.1";
        port = 8080;
        image_proxy = true;
        limiter = false;
      };

      outgoing = {
        request_timeout = 5.0;
        max_request_timeout = 15.0;
        enable_http2 = true;
      };
    };
  };
}
