# MPCMultipeerClient

Wrapper around `MultipeerConnectivity` to simplify common use cases.

**VERY EARLY WORK IN PROGRESS, USE AT YOUR OWN PERIL.**

## Usage

See the `remotecam` demo project for more usage examples.

### Advertise and respond to connect/disconnect/events

```objective-c
[MPCMultipeerClient advertiseWithServiceType:@"myservice"];
[MPCMultipeerClient onConnect:^(MCPeerID *peerID) {
    // Connected :)
}];
[MPCMultipeerClient onDisconnect:^(MCPeerID *peerID) {
    // Disconnected :(
}];
[MPCMultipeerClient onEvent:@"doTheThing" runBlock:^(MCPeerID *peerID, id object) {
    // Do the thing
}];
```

### Browse and send events

```objective-c
[MPCMultipeerClient advertiseWithServiceType:@"myservice"];
[MPCMultipeerClient onConnect:^(MCPeerID *peerID) {
    [MPCMultipeerClient sendEvent:@"doTheThing" withObject:nil];
}];
```

## TODO

* Integrate NSStreams
* Allow MCSessionSendDataUnreliable
* Allow setting encryptionPreference
* Master election
* Use better unique peer ID than their displayName

## License

MIT Licensed.
