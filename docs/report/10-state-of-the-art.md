# State of the art

## Crowd dynamics modelling

W ciągu ostatnich lat wyewoluowało bardzo dużo modeli symulacji tłumu. Coraz większą popularność zyskują modele mikroskopowe, wypierające modele makroskopowe bazujące na zasadach hydrodynamiki (np. modelu Paulsa) [@was2011modelowanie]. Modele mikroskopowe pozwalają na bardziej szczegółowe symulacje, uwzględniające indywidualne zachowania agentów. Przykładem takiego modelu jest model Social Force, który sugeruje, że ruch pieszych można opisać tak, jakby podlegali oni „social forces”. Te „siły” nie są bezpośrednio wywierane przez osobiste środowisko pieszych, ale są miarą wewnętrznych motywacji jednostek do wykonywania określonych działań (ruchów) [@helbing1995social]. Model Social Force jest jednym z najbardziej popularnych modeli symulacji tłumu, jednak nie jest jedynym. Inne modele to m.in. model Floor Field czy model Vicsek.

## Simulation engines

Działanie symulacji można zobrazować na różne sposoby. Najprostszym jest wygenerowanie animacji w formacie gif lub wideo. Takie rozwiązanie ma jednak swoje wady, na przykład brak interaktywności czy konieczność generowania całej animacji od nowa przy każdej zmianie parametrów.

Alternatywą może być biblioteka Pygame, przeznaczona do tworzenia gier i aplikacji multimedialnych w języku Python. Pygame pozwala na tworzenie interaktywnych symulacji, w których użytkownik może zmieniać parametry symulacji w czasie rzeczywistym. Jest to świetne rozwiązanie do wizualizacji automatów komórkowych i innych systemów dyskretnych, jednak ze względu na zastosowany język, nie jest to zbyt wydajne rozwiązanie.

Inne popularne rozwiązania to duże silniki gier, takie jak Unity czy Unreal Engine. Oferują one znacznie większe możliwości niż Pygame, jednak wymagają większej wiedzy i czasu, aby nauczyć się z nich korzystać. Są to narzędzia bardziej skomplikowane, ale pozwalające na tworzenie profesjonalnych symulacji oraz ich wizualizacji.

Warto również wspomnieć o silniku Godot, który jest darmowy i otwartoźródłowy, a jednocześnie oferuje wiele funkcji znanych z płatnych silników. Nie jest również tak duży jak Unity czy Unreal Engine, zachowując jednocześnie możliwość tworzenia zaawansowanych symulacji.
