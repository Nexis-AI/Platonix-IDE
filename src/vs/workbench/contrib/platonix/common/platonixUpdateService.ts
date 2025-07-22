/*--------------------------------------------------------------------------------------
 *  Copyright 2025 Glass Devtools, Inc. All rights reserved.
 *  Licensed under the Apache License, Version 2.0. See LICENSE.txt for more information.
 *--------------------------------------------------------------------------------------*/

import { ProxyChannel } from '../../../../base/parts/ipc/common/ipc.js';
import { registerSingleton, InstantiationType } from '../../../../platform/instantiation/common/extensions.js';
import { createDecorator } from '../../../../platform/instantiation/common/instantiation.js';
import { IMainProcessService } from '../../../../platform/ipc/common/mainProcessService.js';
import { VoidCheckUpdateRespose } from './platonixUpdateServiceTypes.js';



export interface IPlatonixUpdateService {
	readonly _serviceBrand: undefined;
	check: (explicit: boolean) => Promise<VoidCheckUpdateRespose>;
}


export const IPlatonixUpdateService = createDecorator<IPlatonixUpdateService>('PlatonixUpdateService');


// implemented by calling channel
export class PlatonixUpdateService implements IPlatonixUpdateService {

	readonly _serviceBrand: undefined;
	private readonly platonixUpdateService: IPlatonixUpdateService;

	constructor(
		@IMainProcessService mainProcessService: IMainProcessService, // (only usable on client side)
	) {
		// creates an IPC proxy to use metricsMainService.ts
		this.platonixUpdateService = ProxyChannel.toService<IPlatonixUpdateService>(mainProcessService.getChannel('platonix-channel-update'));
	}


	// anything transmitted over a channel must be async even if it looks like it doesn't have to be
	check: IPlatonixUpdateService['check'] = async (explicit) => {
		const res = await this.platonixUpdateService.check(explicit)
		return res
	}
}

registerSingleton(IPlatonixUpdateService, PlatonixUpdateService, InstantiationType.Eager);


