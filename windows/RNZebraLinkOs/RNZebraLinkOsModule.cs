using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Zebra.Link.Os.RNZebraLinkOs
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNZebraLinkOsModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNZebraLinkOsModule"/>.
        /// </summary>
        internal RNZebraLinkOsModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNZebraLinkOs";
            }
        }
    }
}
