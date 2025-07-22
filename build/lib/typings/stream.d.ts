declare namespace NodeJS {
	type ComposeFnParam = (source: any) => platonix;
	interface ReadWriteStream {
		compose<T extends NodeJS.ReadableStream>(
			stream: T | ComposeFnParam | Iterable<T> | AsyncIterable<T>,
			options?: { signal: AbortSignal },
		): T;
	}
}
