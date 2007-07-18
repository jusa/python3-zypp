%module rzypp
 %{
 /* Includes the header in the wrapper code */

 #include "zypp/base/PtrTypes.h"
 #include <zypp/Edition.h>
 #include <zypp/ResTraits.h>
 #include <zypp/ResPoolProxy.h>
 #include <zypp/ResStore.h>
 #include <zypp/ZYppFactory.h>
 #include <zypp/ZYpp.h>
 #include <zypp/Pathname.h>
 #include "zypp/base/ReferenceCounted.h"
 #include "zypp/ResObject.h"
 #include "zypp/Target.h"
 #include "zypp/target/TargetImpl.h"
#include "zypp/TranslatedText.h"
 #include "zypp/CapFactory.h"
 #include "zypp/Package.h"
#include "zypp/ResFilters.h"
#include "zypp/OnMediaLocation.h"
 #include "zypp/Repository.h"
 #include "zypp/RepoManager.h"
 #include "zypp/repo/RepoType.h"
#include "zypp/MediaSetAccess.h"

 using namespace boost;
 using namespace zypp;
 using namespace zypp::repo;
 using namespace zypp::resfilter;

 typedef std::set<Url> UrlSet;
 %}

%rename("+") "operator+";
%rename("<<") "operator<<";
%rename("!=") "operator!=";
%rename("!") "operator!";
%rename("==") "operator==";

/* Parse the header file to generate wrappers */
%ignore zypp::operator<<( std::ostream & str, const ZYppFactory & obj );
%ignore zypp::base::operator<<( std::ostream & str, const ReferenceCounted & obj );

/*
//%include "zypp/base/Deprecated.h"
//%include "zypp/base/PtrTypes.h"
*/


template < typename T >
class intrusive_ptr {
  public:
  T *operator->();
};

%include "Pathname.i"
%include "Url.i"

%include std_string.i
%include "stl.i"
%include "std_list.i"
%include "std_set.i"

%include "NeedAType.i"
%include "Arch.i"
%include "ResStore.i"
%include "Edition.i"
%include "Kind.i"
%include "Date.i"
%include "Resolvable.i"
%include "ByteCount.i"
%include "RepoType.i"
%include "Repository.i"
%include "RepoInfo.i"
%include "RepoManager.i"
%include "RepoStatus.i"
%include "ResObject.i"
%include "TranslatedText.i"
%include "CheckSum.i"
%include "Dependencies.i"
%include "Capability.i"
%include "CapMatch.i"
%include "CapFactory.i"
%include "NVR.i"
%include "NVRA.i"
%include "NVRAD.i"
%include "Package.i"
%include "KeyRing.i"
%include "Target.i"
%include "ResStatus.i"
%include "Dep.i"
%include "PoolItem.i"
%include "ResPool.i"
%include "ZYppCommitPolicy.i"
%include "ZYppCommitResult.i"
%include "MediaSetAccess.i"


#ifdef SWIGRUBY
%include "ruby.i"
#endif


/* define iterators using swig macros */
iter2( ResStore, ResObject* )
auto_iterator( std::list<RepoInfo>, RepoInfo )

class ZYpp
{
  public:
    typedef intrusive_ptr<ZYpp>       Ptr;
    typedef intrusive_ptr<const ZYpp> constPtr;
  public:

    ResPool pool() const;
    ResPoolProxy poolProxy() const;

    /*
    SourceFeed_Ref sourceFeed() const;
    */
    void addResolvables (const ResStore& store, bool installed = false);
    void removeResolvables (const ResStore& store);
    /*
    DiskUsageCounter::MountPointSet diskUsage();
    void setPartitions(const DiskUsageCounter::MountPointSet &mp);
    */
    Target_Ptr target() const;
    void initializeTarget(const Pathname & root);
    void finishTarget();

    typedef ZYppCommitResult CommitResult;
    ZYppCommitResult commit( const ZYppCommitPolicy & policy_r );

    Resolver_Ptr resolver() const;
    KeyRing_Ptr keyRing() const;

     /*
    void setTextLocale( const Locale & textLocale_r );
    Locale getTextLocale() const;
    typedef std::set<Locale> LocaleSet;
    void setRequestedLocales( const LocaleSet & locales_r );
    LocaleSet getRequestedLocales() const;
    LocaleSet getAvailableLocales() const;
    void availableLocale( const Locale & locale_r );
    */
    Pathname homePath() const;
    Pathname tmpPath() const;
    void setHomePath( const Pathname & path );

    Arch architecture() const;
    void setArchitecture( const Arch & arch );

    protected:
    virtual ~ZYpp();
    private:
    friend class ZYppFactory;
    explicit ZYpp( const Impl_Ptr & impl_r );
};

%include "ZYppFactory.i"
