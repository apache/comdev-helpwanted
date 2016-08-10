
hsl2rgb = (h, s, l) ->
    
    h = h % 1;
    s = 1 if s > 1
    l = 1 if l > 1
    if l <= 0.5
        v = (l * (1 + s))
    else
        v = (l + s - l * s);
    if v == 0
        return {
            r: 0,
            g: 0,
            b: 0
        }

    min = 2 * l - v;
    sv = (v - min) / v;
    sh = (6 * h) % 6;
    switcher = Math.floor(sh);
    fract = sh - switcher;
    vsf = v * sv * fract;

    switch switcher
        when 0
            return {
                r: v,
                g: min + vsf,
                b: min
            };
        when 1
            return {
                r: v - vsf,
                g: v,
                b: min
            };
        when 2
            return {
                r: min,
                g: v,
                b: min + vsf
            };
        when 3
            return {
                r: min,
                g: v - vsf,
                b: v
            };
        when 4
            return {
                r: min + vsf,
                g: min,
                b: v
            };
        when 5
            return {
                r: v,
                g: min,
                b: v - vsf
            };
    
    return {
        r: 0,
        g: 0,
        b: 0
    };


genColors = (numColors, saturation, lightness, hex) ->
    cls = []
    baseHue = 1.34;
    for i in [1..numColors]
        c = hsl2rgb(baseHue, saturation, lightness)
        if (hex) 
            h = ( Math.round(c.r*255*255*255) + Math.round(c.g * 255*255) + Math.round(c.b*255) ).toString(16)
            while h.length < 6
                h = '0' + h
            h = '#' + h
            cls.push(h);
        else
                cls.push({
                    r: parseInt(c.r * 255),
                    g: parseInt(c.g * 255),
                    b: parseInt(c.b * 255)
                })
        
        baseHue -= 0.23
        if (baseHue < 0) 
            baseHue += 1
    
    return cls
