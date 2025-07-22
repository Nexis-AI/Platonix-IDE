/*--------------------------------------------------------------------------------------
 *  Copyright 2025 Glass Devtools, Inc. All rights reserved.
 *  Licensed under the Apache License, Version 2.0. See LICENSE.txt for more information.
 *--------------------------------------------------------------------------------------*/

import { mountFnGenerator } from '../util/mountFnGenerator.js'
import { PlatonixCommandBarMain } from './PlatonixCommandBar.js'
import { PlatonixSelectionHelperMain } from './PlatonixSelectionHelper.js'

export const mountPlatonixCommandBar = mountFnGenerator(PlatonixCommandBarMain)

export const mountPlatonixSelectionHelper = mountFnGenerator(PlatonixSelectionHelperMain)

