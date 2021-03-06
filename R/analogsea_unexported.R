droplet_ip = function (x)
{
  v4 <- x$network$v4
  if (length(v4) == 0) {
    stop("No network interface registered for this droplet\n  Try refreshing like: droplet(d$id)",
         call. = FALSE)
  }
  ips <- do.call("rbind", lapply(v4, as.data.frame))
  public_ip <- ips$type == "public"
  if (!any(public_ip)) {
    ip <- v4[[1]]$ip_address
  }
  else {
    ip <- ips$ip_address[public_ip][[1]]
  }
  ip
}
droplet_ip_safe = function (x)
{
  res <- tryCatch(droplet_ip(x), error = function(e) e)
  if (inherits(res, "simpleError"))
    "droplet likely not up yet"
  else res
}
