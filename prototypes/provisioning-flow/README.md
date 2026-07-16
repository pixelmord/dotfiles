# Provisioning contract prototype — throwaway

**Question.** Can a visible, repository-local contract provision a fresh developer machine from Proton Pass while keeping the unattended control-plane runner on sops+age, without an untracked central `~/.secrets` tree?

Run it from a dotfiles checkout:

```bash
./bin/dot-provision-prototype
```

It is an interactive state-model prototype, not a provisioner: it reads no
secrets, invokes neither Proton Pass nor sops, and writes no files. Choose each
trust context and inspect the full state and proposed layout.

## Candidate contract being tested

- Every developer repository that needs secrets owns a committed `.secrets/`
  directory. `manifest.yaml` lists allowed target paths and file modes; `.tmpl`
  files contain only `pass://` references. Thus a fresh checkout contains the
  instructions needed to provision itself, while Proton Pass remains the only
  developer secret store.
- The real, eventual command has the shape `dot provision dev <repo>`: verify a
  human Proton Pass session, read that checkout's manifest, resolve templates,
  and atomically materialize only declared files. Secret outputs are regular,
  restrictive-mode files — never symlinks.
- The unattended runner deliberately uses a separate contract: encrypted
  `secrets/runner.enc.yaml`, `.sops.yaml`, an age key only on its LXC, and a
  short-lived `0700` runtime directory. It never receives the Proton Pass CLI.

## Deliberately absent

There is no `~/.secrets` mirror, secret value, `pass inject` invocation, sops
key, real manifest parser, overwrite behavior, or test suite. Those are
implementation concerns after this prototype validates the contract.
