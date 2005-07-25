// Copyright (C) 2005 Laurent Sansonetti
//
// Alexandria is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation; either version 2 of the
// License, or (at your option) any later version.
//
// Alexandria is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public
// License along with Alexandria; see the file COPYING.  If not,
// write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
// Boston, MA 02111-1307, USA.

#import <RubyCocoa/RBRuntime.h>
#import <mach-o/dyld.h>
#import <sys/param.h>

#import "ruby.h"

int
main (int argc, const char *argv[])
{
    VALUE               paths;
    NSAutoreleasePool * pool;
    NSString *          resourcePath;
    NSString *          path;

    RBRubyCocoaInit ();
    
    paths = rb_gv_get (":");

    pool = [[NSAutoreleasePool alloc] init];    

    resourcePath = [[NSBundle mainBundle] resourcePath];

    path = [resourcePath stringByAppendingPathComponent:@"libyaz.2.dylib"];
    assert (NSAddImage ([path cString], 
                        NSADDIMAGE_OPTION_WITH_SEARCHING) != NULL);

    path = [resourcePath stringByAppendingPathComponent:@"ruby"];
    rb_ary_unshift (paths, rb_str_new2([path cString]));    
    
    path = [path stringByAppendingPathComponent:[NSString stringWithCString:RUBY_PLATFORM]];
    rb_ary_unshift (paths, rb_str_new2([path cString]));    
    
    [pool release];
    
    return RBApplicationMain ("main.rb", argc, argv);
}