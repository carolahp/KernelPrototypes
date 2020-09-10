# KernelPrototypes

```
prototypes := MPrototypes new name: #Prototypes; yourself.
prototypes loadTonelRepository: './bootstrap/language-definitions-new-repo/PrototypesFull3'.

prototypes loadCustomClasses.
"prototypes browse."
prototypes test.
prototypes prepareBuilder.
prototypes spurImage testStub.
prototypes builder installClasses.
prototypes builder installMethods.
prototypes builder installProcess.

image := prototypes spurImage.
image test.
imageFile := prototypes writeImage.
imageFile runBashScript
```
