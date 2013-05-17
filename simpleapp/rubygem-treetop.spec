#
# spec file for package rubygem-treetop
#
# Copyright (c) 2012 SUSE LINUX Products GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#


Name:           rubygem-treetop
Version:        1.4.12
Release:        30.14
%define mod_name treetop
%define mod_full_name %{mod_name}-%{version}

BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildRequires:  ruby-macros >= 1
Url:            https://github.com/cjheath/treetop
Source:         %{mod_full_name}.gem
Summary:        A Ruby-based text parsing and interpretation DSL
License:        MIT
Group:          Development/Languages/Ruby

%description
A Ruby-based text parsing and interpretation DSL

%package doc
Summary:        RDoc documentation for %{mod_name}
Group:          Development/Languages/Ruby
Requires:       %{name} = %{version}

%description doc
Documentation generated at gem installation time.
Usually in RDoc and RI formats.

%package testsuite
Summary:        Test suite for %{mod_name}
Group:          Development/Languages/Ruby
Requires:       %{name} = %{version}

%description testsuite
Test::Unit or RSpec files, useful for developers.

%prep
#gem_unpack
#if you need patches, apply them here and replace the # with a % sign in the surrounding lines
#gem_build

%build

%install
%gem_install -f

%files
%defattr(-,root,root,-)
%{_bindir}/tt
%{_libdir}/ruby/gems/%{rb_ver}/cache/%{mod_full_name}.gem
%{_libdir}/ruby/gems/%{rb_ver}/gems/%{mod_full_name}/
%exclude %{_libdir}/ruby/gems/%{rb_ver}/gems/%{mod_full_name}/spec
%{_libdir}/ruby/gems/%{rb_ver}/specifications/%{mod_full_name}.gemspec

%files doc
%defattr(-,root,root,-)
%doc %{_libdir}/ruby/gems/%{rb_ver}/doc/%{mod_full_name}/

%files testsuite
%defattr(-,root,root,-)
%{_libdir}/ruby/gems/%{rb_ver}/gems/%{mod_full_name}/spec

%changelog
* Tue Oct 30 2012 coolo@suse.com
- updated to version 1.4.12
* Fri Oct 12 2012 coolo@suse.com
- updated to version 1.4.11, no changelog
* Tue Jul 31 2012 jreidinger@suse.com
- use new gem2rpm to get new provisions
* Wed Apr  4 2012 coolo@suse.com
- update to 1.4.10, no changelog
* Fri Mar 23 2012 saschpe@suse.de
- Spec file cleanup:
  * Factory preparation
* Wed Dec 14 2011 jreidinger@suse.com
- move more documentation to subpackage
- don't have executable script on documenation
* Thu Dec  9 2010 chris@computersalat.de
- update to 1.4.9
- fix url
* Mon Jun 14 2010 mrueckert@suse.de
- update to version 1.4.8
* Fri Jun 11 2010 mrueckert@suse.de
- use rubygems_requires macro
* Fri Dec 25 2009 prusnak@suse.cz
- update to 1.4.3
* Thu Oct  1 2009 mrueckert@suse.de
- update to 1.4.2
* Tue Mar 31 2009 mrueckert@suse.de
- initial package
