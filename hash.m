function h = hash(str)
    md = java.security.MessageDigest.getInstance("MD5");
    str = java.lang.String(str);
    md.update(str.getBytes());
    h = char(md.digest())';
    h = matlab.net.base64encode(h);