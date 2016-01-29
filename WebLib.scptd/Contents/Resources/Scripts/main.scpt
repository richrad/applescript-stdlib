FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� WebLib -- commands for manipulating URLs and sending HTTP requests

TO DO:

- `split URL`, `join URL`; note that `join URL` should allow `using base URL` to be optionally specified (in which case the URL being joined might be either a record or a string; see urllib.parse.urljoin); NSURL provides following properties:

		scheme
		user
		password
		host
		port
		path
		pathExtension
		pathComponents
		parameterString
		query
		fragment
		
		(Q. would it make sense to keep user+password+host+port combined, and provide separate commands for splitting and joining that, or else include properties for both representations c.f. `convert record to date`, or else group it as a sub-record and provide boolean option on `split URL` indicating whether to keep it together as text or decompose into sub-record)

- `normalize URL`? see NSURL's standardizedURL()

- `split URL query`, `join URL query` -- {{"foo", "xyz"}, {"bar", 123}} <-> "foo=xyz&bar=123"; note that this should work for both URL query strings and 'application/x-www-form-urlencoded' HTTP body data; e.g. see Python's [horribly named]:

	urllib.parse.parse_qsl(qs, keep_blank_values=False, strict_parsing=False, encoding='utf-8', errors='replace')
	urllib.parse.urlencode(query, doseq=False, safe='', encoding=None, errors=None)


- `escape URL`, `unescape URL` -- see:
	
	@interface NSString (NSURLUtilities)

	// Returns a new string made from the receiver by replacing all characters not in the allowedCharacters set with percent encoded characters. UTF-8 encoding is used to determine the correct percent encoded characters. Entire URL strings cannot be percent-encoded. This method is intended to percent-encode an URL component or subcomponent string, NOT the entire URL string. Any characters in allowedCharacters outside of the 7-bit ASCII range are ignored.
	- (nullable NSString)stringByAddingPercentEncodingWithAllowedCharacters:(NSCharacterSet)allowedCharacters NS_AVAILABLE(10_9, 7_0);

	// Returns a new string made from the receiver by replacing all percent encoded sequences with the matching UTF-8 characters.
	@property (nullable, readonly, copy) NSString *stringByRemovingPercentEncoding NS_AVAILABLE(10_9, 7_0);

	@end
	
	and in Python:

	 urllib.parse.quote(string, safe='/', encoding=None, errors=None)
	 urllib.parse.quote_plus(string, safe='', encoding=None, errors=None) -- note: `form quoting` should be a boolean option to `escape URL`, indicating whether or not spaces should be escaped as '+' (and '+' as '%NN', and use "" instead of "/" as default `safe` chars)
	 urllib.parse.unquote(string, encoding='utf-8', errors='replace') -- e.g. unquote('/El%20Ni%C3%B1o/') yields '/El Ni�o/'
	 urllib.parse.unquote_plus(string, encoding='utf-8', errors='replace') -- again, include `form quoting` boolean option


- longer term, it'd be useful to provide some sort of 'JSON schema' support, where a nestable list/record template structure could be used to describe the expected/required structure (including required types and default values); this is probably getting out of scope for stdlib though (which should focus on the basics that everyone expects, and leave clever/advanced/complex features to 3rd-party libraries that can be installed when needed)


- `send HTTP request` -- urllib.request.Request(url, data=None, headers={}, origin_req_host=None, unverifiable=False, method=None) [method=GET/POST/PUT/etc]; see NSURLSession, NSURLRequest, NSURLResponse

	- Q. what API? e.g. should command simply block until completion or timeout? (an async API would probably be overkill, not to mention difficult, for most AS users; any users that do need more advanced features can always drop down into Cocoa via ASOC)

	- Q. need to give some thought to encodings in HTTP body data: simplest might be for body to be either `text` or `data`, and leave encoding/decoding to TextLib (which currently doesn't support this, but could be made to); Q. what AE type to assign to data objects: cRawData ('rdat'), or something more specific?


- What about including a basic HTTP server, c.f. Python's http.server module? Wouldn't be suitable for public web (no security, no concurrency), but might be handy for localhost/private intranet use. This'd presumably be implemented as a `serve HTTP requests using SCRIPT [on port NUMBER]` handler that takes a user-supplied script object containing a `handleHTTPRequest` handler which it then calls each time a request is received. Higher-level APIs, e.g. routing on method, path and/or content-type, could be done by the user first passing her own script object to a standard 'HTTP request router' object that introspects it for routing information (e.g. a record whose keys match the object's method names and values contain the pattern matching info) and generates the appropriate routing tables and method call objects; the resulting wrapper object then being passed to `handleHTTPRequest` as normal. (TBH, as in case of TaskLib, this is probably out of scope for stdlib and belongs in its own WebServerLib.)

     � 	 	'T   W e b L i b   - -   c o m m a n d s   f o r   m a n i p u l a t i n g   U R L s   a n d   s e n d i n g   H T T P   r e q u e s t s 
 
 T O   D O : 
 
 -   ` s p l i t   U R L ` ,   ` j o i n   U R L ` ;   n o t e   t h a t   ` j o i n   U R L `   s h o u l d   a l l o w   ` u s i n g   b a s e   U R L `   t o   b e   o p t i o n a l l y   s p e c i f i e d   ( i n   w h i c h   c a s e   t h e   U R L   b e i n g   j o i n e d   m i g h t   b e   e i t h e r   a   r e c o r d   o r   a   s t r i n g ;   s e e   u r l l i b . p a r s e . u r l j o i n ) ;   N S U R L   p r o v i d e s   f o l l o w i n g   p r o p e r t i e s : 
 
 	 	 s c h e m e 
 	 	 u s e r 
 	 	 p a s s w o r d 
 	 	 h o s t 
 	 	 p o r t 
 	 	 p a t h 
 	 	 p a t h E x t e n s i o n 
 	 	 p a t h C o m p o n e n t s 
 	 	 p a r a m e t e r S t r i n g 
 	 	 q u e r y 
 	 	 f r a g m e n t 
 	 	 
 	 	 ( Q .   w o u l d   i t   m a k e   s e n s e   t o   k e e p   u s e r + p a s s w o r d + h o s t + p o r t   c o m b i n e d ,   a n d   p r o v i d e   s e p a r a t e   c o m m a n d s   f o r   s p l i t t i n g   a n d   j o i n i n g   t h a t ,   o r   e l s e   i n c l u d e   p r o p e r t i e s   f o r   b o t h   r e p r e s e n t a t i o n s   c . f .   ` c o n v e r t   r e c o r d   t o   d a t e ` ,   o r   e l s e   g r o u p   i t   a s   a   s u b - r e c o r d   a n d   p r o v i d e   b o o l e a n   o p t i o n   o n   ` s p l i t   U R L `   i n d i c a t i n g   w h e t h e r   t o   k e e p   i t   t o g e t h e r   a s   t e x t   o r   d e c o m p o s e   i n t o   s u b - r e c o r d ) 
 
 -   ` n o r m a l i z e   U R L ` ?   s e e   N S U R L ' s   s t a n d a r d i z e d U R L ( ) 
 
 -   ` s p l i t   U R L   q u e r y ` ,   ` j o i n   U R L   q u e r y `   - -   { { " f o o " ,   " x y z " } ,   { " b a r " ,   1 2 3 } }   < - >   " f o o = x y z & b a r = 1 2 3 " ;   n o t e   t h a t   t h i s   s h o u l d   w o r k   f o r   b o t h   U R L   q u e r y   s t r i n g s   a n d   ' a p p l i c a t i o n / x - w w w - f o r m - u r l e n c o d e d '   H T T P   b o d y   d a t a ;   e . g .   s e e   P y t h o n ' s   [ h o r r i b l y   n a m e d ] : 
 
 	 u r l l i b . p a r s e . p a r s e _ q s l ( q s ,   k e e p _ b l a n k _ v a l u e s = F a l s e ,   s t r i c t _ p a r s i n g = F a l s e ,   e n c o d i n g = ' u t f - 8 ' ,   e r r o r s = ' r e p l a c e ' ) 
 	 u r l l i b . p a r s e . u r l e n c o d e ( q u e r y ,   d o s e q = F a l s e ,   s a f e = ' ' ,   e n c o d i n g = N o n e ,   e r r o r s = N o n e ) 
 
 
 -   ` e s c a p e   U R L ` ,   ` u n e s c a p e   U R L `   - -   s e e : 
 	 
 	 @ i n t e r f a c e   N S S t r i n g   ( N S U R L U t i l i t i e s ) 
 
 	 / /   R e t u r n s   a   n e w   s t r i n g   m a d e   f r o m   t h e   r e c e i v e r   b y   r e p l a c i n g   a l l   c h a r a c t e r s   n o t   i n   t h e   a l l o w e d C h a r a c t e r s   s e t   w i t h   p e r c e n t   e n c o d e d   c h a r a c t e r s .   U T F - 8   e n c o d i n g   i s   u s e d   t o   d e t e r m i n e   t h e   c o r r e c t   p e r c e n t   e n c o d e d   c h a r a c t e r s .   E n t i r e   U R L   s t r i n g s   c a n n o t   b e   p e r c e n t - e n c o d e d .   T h i s   m e t h o d   i s   i n t e n d e d   t o   p e r c e n t - e n c o d e   a n   U R L   c o m p o n e n t   o r   s u b c o m p o n e n t   s t r i n g ,   N O T   t h e   e n t i r e   U R L   s t r i n g .   A n y   c h a r a c t e r s   i n   a l l o w e d C h a r a c t e r s   o u t s i d e   o f   t h e   7 - b i t   A S C I I   r a n g e   a r e   i g n o r e d . 
 	 -   ( n u l l a b l e   N S S t r i n g ) s t r i n g B y A d d i n g P e r c e n t E n c o d i n g W i t h A l l o w e d C h a r a c t e r s : ( N S C h a r a c t e r S e t ) a l l o w e d C h a r a c t e r s   N S _ A V A I L A B L E ( 1 0 _ 9 ,   7 _ 0 ) ; 
 
 	 / /   R e t u r n s   a   n e w   s t r i n g   m a d e   f r o m   t h e   r e c e i v e r   b y   r e p l a c i n g   a l l   p e r c e n t   e n c o d e d   s e q u e n c e s   w i t h   t h e   m a t c h i n g   U T F - 8   c h a r a c t e r s . 
 	 @ p r o p e r t y   ( n u l l a b l e ,   r e a d o n l y ,   c o p y )   N S S t r i n g   * s t r i n g B y R e m o v i n g P e r c e n t E n c o d i n g   N S _ A V A I L A B L E ( 1 0 _ 9 ,   7 _ 0 ) ; 
 
 	 @ e n d 
 	 
 	 a n d   i n   P y t h o n : 
 
 	   u r l l i b . p a r s e . q u o t e ( s t r i n g ,   s a f e = ' / ' ,   e n c o d i n g = N o n e ,   e r r o r s = N o n e ) 
 	   u r l l i b . p a r s e . q u o t e _ p l u s ( s t r i n g ,   s a f e = ' ' ,   e n c o d i n g = N o n e ,   e r r o r s = N o n e )   - -   n o t e :   ` f o r m   q u o t i n g `   s h o u l d   b e   a   b o o l e a n   o p t i o n   t o   ` e s c a p e   U R L ` ,   i n d i c a t i n g   w h e t h e r   o r   n o t   s p a c e s   s h o u l d   b e   e s c a p e d   a s   ' + '   ( a n d   ' + '   a s   ' % N N ' ,   a n d   u s e   " "   i n s t e a d   o f   " / "   a s   d e f a u l t   ` s a f e `   c h a r s ) 
 	   u r l l i b . p a r s e . u n q u o t e ( s t r i n g ,   e n c o d i n g = ' u t f - 8 ' ,   e r r o r s = ' r e p l a c e ' )   - -   e . g .   u n q u o t e ( ' / E l % 2 0 N i % C 3 % B 1 o / ' )   y i e l d s   ' / E l   N i � o / ' 
 	   u r l l i b . p a r s e . u n q u o t e _ p l u s ( s t r i n g ,   e n c o d i n g = ' u t f - 8 ' ,   e r r o r s = ' r e p l a c e ' )   - -   a g a i n ,   i n c l u d e   ` f o r m   q u o t i n g `   b o o l e a n   o p t i o n 
 
 
 -   l o n g e r   t e r m ,   i t ' d   b e   u s e f u l   t o   p r o v i d e   s o m e   s o r t   o f   ' J S O N   s c h e m a '   s u p p o r t ,   w h e r e   a   n e s t a b l e   l i s t / r e c o r d   t e m p l a t e   s t r u c t u r e   c o u l d   b e   u s e d   t o   d e s c r i b e   t h e   e x p e c t e d / r e q u i r e d   s t r u c t u r e   ( i n c l u d i n g   r e q u i r e d   t y p e s   a n d   d e f a u l t   v a l u e s ) ;   t h i s   i s   p r o b a b l y   g e t t i n g   o u t   o f   s c o p e   f o r   s t d l i b   t h o u g h   ( w h i c h   s h o u l d   f o c u s   o n   t h e   b a s i c s   t h a t   e v e r y o n e   e x p e c t s ,   a n d   l e a v e   c l e v e r / a d v a n c e d / c o m p l e x   f e a t u r e s   t o   3 r d - p a r t y   l i b r a r i e s   t h a t   c a n   b e   i n s t a l l e d   w h e n   n e e d e d ) 
 
 
 -   ` s e n d   H T T P   r e q u e s t `   - -   u r l l i b . r e q u e s t . R e q u e s t ( u r l ,   d a t a = N o n e ,   h e a d e r s = { } ,   o r i g i n _ r e q _ h o s t = N o n e ,   u n v e r i f i a b l e = F a l s e ,   m e t h o d = N o n e )   [ m e t h o d = G E T / P O S T / P U T / e t c ] ;   s e e   N S U R L S e s s i o n ,   N S U R L R e q u e s t ,   N S U R L R e s p o n s e 
 
 	 -   Q .   w h a t   A P I ?   e . g .   s h o u l d   c o m m a n d   s i m p l y   b l o c k   u n t i l   c o m p l e t i o n   o r   t i m e o u t ?   ( a n   a s y n c   A P I   w o u l d   p r o b a b l y   b e   o v e r k i l l ,   n o t   t o   m e n t i o n   d i f f i c u l t ,   f o r   m o s t   A S   u s e r s ;   a n y   u s e r s   t h a t   d o   n e e d   m o r e   a d v a n c e d   f e a t u r e s   c a n   a l w a y s   d r o p   d o w n   i n t o   C o c o a   v i a   A S O C ) 
 
 	 -   Q .   n e e d   t o   g i v e   s o m e   t h o u g h t   t o   e n c o d i n g s   i n   H T T P   b o d y   d a t a :   s i m p l e s t   m i g h t   b e   f o r   b o d y   t o   b e   e i t h e r   ` t e x t `   o r   ` d a t a ` ,   a n d   l e a v e   e n c o d i n g / d e c o d i n g   t o   T e x t L i b   ( w h i c h   c u r r e n t l y   d o e s n ' t   s u p p o r t   t h i s ,   b u t   c o u l d   b e   m a d e   t o ) ;   Q .   w h a t   A E   t y p e   t o   a s s i g n   t o   d a t a   o b j e c t s :   c R a w D a t a   ( ' r d a t ' ) ,   o r   s o m e t h i n g   m o r e   s p e c i f i c ? 
 
 
 -   W h a t   a b o u t   i n c l u d i n g   a   b a s i c   H T T P   s e r v e r ,   c . f .   P y t h o n ' s   h t t p . s e r v e r   m o d u l e ?   W o u l d n ' t   b e   s u i t a b l e   f o r   p u b l i c   w e b   ( n o   s e c u r i t y ,   n o   c o n c u r r e n c y ) ,   b u t   m i g h t   b e   h a n d y   f o r   l o c a l h o s t / p r i v a t e   i n t r a n e t   u s e .   T h i s ' d   p r e s u m a b l y   b e   i m p l e m e n t e d   a s   a   ` s e r v e   H T T P   r e q u e s t s   u s i n g   S C R I P T   [ o n   p o r t   N U M B E R ] `   h a n d l e r   t h a t   t a k e s   a   u s e r - s u p p l i e d   s c r i p t   o b j e c t   c o n t a i n i n g   a   ` h a n d l e H T T P R e q u e s t `   h a n d l e r   w h i c h   i t   t h e n   c a l l s   e a c h   t i m e   a   r e q u e s t   i s   r e c e i v e d .   H i g h e r - l e v e l   A P I s ,   e . g .   r o u t i n g   o n   m e t h o d ,   p a t h   a n d / o r   c o n t e n t - t y p e ,   c o u l d   b e   d o n e   b y   t h e   u s e r   f i r s t   p a s s i n g   h e r   o w n   s c r i p t   o b j e c t   t o   a   s t a n d a r d   ' H T T P   r e q u e s t   r o u t e r '   o b j e c t   t h a t   i n t r o s p e c t s   i t   f o r   r o u t i n g   i n f o r m a t i o n   ( e . g .   a   r e c o r d   w h o s e   k e y s   m a t c h   t h e   o b j e c t ' s   m e t h o d   n a m e s   a n d   v a l u e s   c o n t a i n   t h e   p a t t e r n   m a t c h i n g   i n f o )   a n d   g e n e r a t e s   t h e   a p p r o p r i a t e   r o u t i n g   t a b l e s   a n d   m e t h o d   c a l l   o b j e c t s ;   t h e   r e s u l t i n g   w r a p p e r   o b j e c t   t h e n   b e i n g   p a s s e d   t o   ` h a n d l e H T T P R e q u e s t `   a s   n o r m a l .   ( T B H ,   a s   i n   c a s e   o f   T a s k L i b ,   t h i s   i s   p r o b a b l y   o u t   o f   s c o p e   f o r   s t d l i b   a n d   b e l o n g s   i n   i t s   o w n   W e b S e r v e r L i b . ) 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t     !   l     ��������  ��  ��   !  " # " l      $ % & $ j    �� '�� 0 _supportlib _supportLib ' N     ( ( 4    �� )
�� 
scpt ) m     * * � + + " L i b r a r y S u p p o r t L i b % "  used for parameter checking    & � , , 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g #  - . - l     ��������  ��  ��   .  / 0 / l     ��������  ��  ��   0  1 2 1 i    3 4 3 I      �� 5���� 
0 _error   5  6 7 6 o      ���� 0 handlername handlerName 7  8 9 8 o      ���� 0 etext eText 9  : ; : o      ���� 0 enumber eNumber ;  < = < o      ���� 0 efrom eFrom =  >�� > o      ���� 
0 eto eTo��  ��   4 n     ? @ ? I    �� A���� &0 throwcommanderror throwCommandError A  B C B m     D D � E E  W e b L i b C  F G F o    ���� 0 handlername handlerName G  H I H o    ���� 0 etext eText I  J K J o    	���� 0 enumber eNumber K  L M L o   	 
���� 0 efrom eFrom M  N�� N o   
 ���� 
0 eto eTo��  ��   @ o     ���� 0 _supportlib _supportLib 2  O P O l     ��������  ��  ��   P  Q R Q l     ��������  ��  ��   R  S T S l     �� U V��   U J D--------------------------------------------------------------------    V � W W � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - T  X Y X l     �� Z [��   Z   URL conversion    [ � \ \    U R L   c o n v e r s i o n Y  ] ^ ] l     ��������  ��  ��   ^  _ ` _ i    a b a I     �� c��
�� .Web:SplUnull���     ctxt c o      ���� 0 urltext urlText��   b Q     $ d e f d k     g g  h i h r     j k j n    l m l I    �� n���� "0 astextparameter asTextParameter n  o p o o    	���� 0 urltext urlText p  q�� q m   	 
 r r � s s  ��  ��   m o    ���� 0 _supportlib _supportLib k o      ���� 0 urltext urlText i  t�� t l   ��������  ��  ��  ��   e R      �� u v
�� .ascrerr ****      � **** u o      ���� 0 etext eText v �� w x
�� 
errn w o      ���� 0 enumber eNumber x �� y z
�� 
erob y o      ���� 0 efrom eFrom z �� {��
�� 
errt { o      ���� 
0 eto eTo��   f I    $�� |���� 
0 _error   |  } ~ } m       � � �  s p l i t   U R L ~  � � � o    ���� 0 etext eText �  � � � o    ���� 0 enumber eNumber �  � � � o    ���� 0 efrom eFrom �  ��� � o     ���� 
0 eto eTo��  ��   `  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i    � � � I     �� � �
�� .Web:JoiUnull���     **** � o      ���� 0 	urlrecord 	urlRecord � �� ���
�� 
Base � |���� ��� ���  ��   � o      ���� 0 baseurl baseURL��   � l      ����� � m       � � � � �  ��  ��  ��   � l    2 � � � � Q     2 � � � � k      � �  � � � r     � � � n    � � � I    �� ����� &0 asrecordparameter asRecordParameter �  � � � o    	���� 0 	urlrecord 	urlRecord �  ��� � m   	 
 � � � � �  ��  ��   � o    ���� 0 _supportlib _supportLib � o      ���� 0 	urlrecord 	urlRecord �  � � � l    � � � � r     � � � n    � � � I    �� ����� "0 astextparameter asTextParameter �  � � � o    ���� 0 baseurl baseURL �  ��� � m     � � � � �  u s i n g   b a s e   U R L��  ��   � o    ���� 0 _supportlib _supportLib � o      ���� 0 baseurl baseURL � Q K TO DO: need to append default record and check for unrecognized properties    � � � � �   T O   D O :   n e e d   t o   a p p e n d   d e f a u l t   r e c o r d   a n d   c h e c k   f o r   u n r e c o g n i z e d   p r o p e r t i e s �  ��� � l   ��������  ��  ��  ��   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 etext eText � �� � �
�� 
errn � o      ���� 0 enumber eNumber � �� � �
�� 
erob � o      ���� 0 efrom eFrom � �� ���
�� 
errt � o      ���� 
0 eto eTo��   � I   ( 2�� ����� 
0 _error   �  � � � m   ) * � � � � �  j o i n   U R L �  � � � o   * +���� 0 etext eText �  � � � o   + ,�� 0 enumber eNumber �  � � � o   , -�~�~ 0 efrom eFrom �  ��} � o   - .�|�| 
0 eto eTo�}  ��   � y s TO DO: also allow urlRecord to be text path? (Q. would that substitute or append to any existing path in baseURL?)    � � � � �   T O   D O :   a l s o   a l l o w   u r l R e c o r d   t o   b e   t e x t   p a t h ?   ( Q .   w o u l d   t h a t   s u b s t i t u t e   o r   a p p e n d   t o   a n y   e x i s t i n g   p a t h   i n   b a s e U R L ? ) �  � � � l     �{�z�y�{  �z  �y   �  � � � l     �x�w�v�x  �w  �v   �  � � � l     �u � ��u   �  -----    � � � � 
 - - - - - �  � � � l     �t � ��t   � 7 1 encode/decode '%XX' escapes (UTF8 encoding only)    � � � � b   e n c o d e / d e c o d e   ' % X X '   e s c a p e s   ( U T F 8   e n c o d i n g   o n l y ) �  � � � l     �s�r�q�s  �r  �q   �  � � � i   ! � � � I     �p ��o
�p .Web:EscUnull���     ctxt � o      �n�n 0 urltext urlText�o   � Q     $ � � � � k     � �  � � � r     � � � n    � � � I    �m ��l�m "0 astextparameter asTextParameter �  � � � o    	�k�k 0 urltext urlText �  ��j � m   	 
 � � � � �  �j  �l   � o    �i�i 0 _supportlib _supportLib � o      �h�h 0 urltext urlText �  ��g � l   �f�e�d�f  �e  �d  �g   � R      �c � �
�c .ascrerr ****      � **** � o      �b�b 0 etext eText � �a � �
�a 
errn � o      �`�` 0 enumber eNumber � �_ � �
�_ 
erob � o      �^�^ 0 efrom eFrom � �] ��\
�] 
errt � o      �[�[ 
0 eto eTo�\   � I    $�Z ��Y�Z 
0 _error   �  � � � m       � * e s c a p e   U R L   c h a r a c t e r s �  o    �X�X 0 etext eText  o    �W�W 0 enumber eNumber  o    �V�V 0 efrom eFrom �U o     �T�T 
0 eto eTo�U  �Y   � 	
	 l     �S�R�Q�S  �R  �Q  
  l     �P�O�N�P  �O  �N    i  " % I     �M�L
�M .Web:UneUnull���     ctxt o      �K�K 0 urltext urlText�L   Q     $ k      r     n    I    �J�I�J "0 astextparameter asTextParameter  o    	�H�H 0 urltext urlText �G m   	 
   �!!  �G  �I   o    �F�F 0 _supportlib _supportLib o      �E�E 0 urltext urlText "�D" l   �C�B�A�C  �B  �A  �D   R      �@#$
�@ .ascrerr ****      � ****# o      �?�? 0 etext eText$ �>%&
�> 
errn% o      �=�= 0 enumber eNumber& �<'(
�< 
erob' o      �;�; 0 efrom eFrom( �:)�9
�: 
errt) o      �8�8 
0 eto eTo�9   I    $�7*�6�7 
0 _error  * +,+ m    -- �.. . u n e s c a p e   U R L   c h a r a c t e r s, /0/ o    �5�5 0 etext eText0 121 o    �4�4 0 enumber eNumber2 343 o    �3�3 0 efrom eFrom4 5�25 o     �1�1 
0 eto eTo�2  �6   676 l     �0�/�.�0  �/  �.  7 898 l     �-�,�+�-  �,  �+  9 :;: l     �*<=�*  <  -----   = �>> 
 - - - - -; ?@? l     �)AB�)  A + % parse/format "key=value&..." strings   B �CC J   p a r s e / f o r m a t   " k e y = v a l u e & . . . "   s t r i n g s@ DED l     �(�'�&�(  �'  �&  E FGF l     �%HI�%  H � � note: these names overlap `split url`, but as long as `query string` doesn't get defined as a keyword anywhere (ensuring the word `query` can't be mistaken for an identifier) there shouldn't be any ambiguity   I �JJ�   n o t e :   t h e s e   n a m e s   o v e r l a p   ` s p l i t   u r l ` ,   b u t   a s   l o n g   a s   ` q u e r y   s t r i n g `   d o e s n ' t   g e t   d e f i n e d   a s   a   k e y w o r d   a n y w h e r e   ( e n s u r i n g   t h e   w o r d   ` q u e r y `   c a n ' t   b e   m i s t a k e n   f o r   a n   i d e n t i f i e r )   t h e r e   s h o u l d n ' t   b e   a n y   a m b i g u i t yG KLK l     �$�#�"�$  �#  �"  L MNM l     �!OP�!  O M G note: these should probably do '%xx' escaping/unescaping automatically   P �QQ �   n o t e :   t h e s e   s h o u l d   p r o b a b l y   d o   ' % x x '   e s c a p i n g / u n e s c a p i n g   a u t o m a t i c a l l yN RSR l     � ���   �  �  S TUT i  & )VWV I     �X�
� .Web:SplQnull���     ctxtX o      �� 0 	querytext 	queryText�  W Q     $YZ[Y k    \\ ]^] r    _`_ n   aba I    �c�� "0 astextparameter asTextParameterc ded o    	�� 0 	querytext 	queryTexte f�f m   	 
gg �hh  �  �  b o    �� 0 _supportlib _supportLib` o      �� 0 	querytext 	queryText^ i�i l   ����  �  �  �  Z R      �jk
� .ascrerr ****      � ****j o      �� 0 etext eTextk �lm
� 
errnl o      �� 0 enumber eNumberm �no
� 
erobn o      �� 0 efrom eFromo �
p�	
�
 
errtp o      �� 
0 eto eTo�	  [ I    $�q�� 
0 _error  q rsr m    tt �uu $ s p l i t   q u e r y   s t r i n gs vwv o    �� 0 etext eTextw xyx o    �� 0 enumber eNumbery z{z o    �� 0 efrom eFrom{ |�| o     �� 
0 eto eTo�  �  U }~} l     � �����   ��  ��  ~ � l     ��������  ��  ��  � ��� i  * -��� I     �����
�� .Web:JoiQnull���     ctxt� o      ���� 0 	querylist 	queryList��  � l    $���� Q     $���� k    �� ��� r    ��� n   ��� I    ������� "0 aslistparameter asListParameter� ��� o    	���� 0 	querylist 	queryList� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 	querylist 	queryList� ���� l   ��������  ��  ��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I    $������� 
0 _error  � ��� m    �� ��� " j o i n   q u e r y   s t r i n g� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o     ���� 
0 eto eTo��  ��  �GA list of form: {{keyText,aValue},...} -- TO DO: what types should be allowed for values? numeric values will need to be converted to canonical text not sure how `true` and `false` should be treated; dates should either convert to ISO8601 or be rejected; should `missing value` indicate no value or just use empty text ""?   � ����   l i s t   o f   f o r m :   { { k e y T e x t , a V a l u e } , . . . }   - -   T O   D O :   w h a t   t y p e s   s h o u l d   b e   a l l o w e d   f o r   v a l u e s ?   n u m e r i c   v a l u e s   w i l l   n e e d   t o   b e   c o n v e r t e d   t o   c a n o n i c a l   t e x t   n o t   s u r e   h o w   ` t r u e `   a n d   ` f a l s e `   s h o u l d   b e   t r e a t e d ;   d a t e s   s h o u l d   e i t h e r   c o n v e r t   t o   I S O 8 6 0 1   o r   b e   r e j e c t e d ;   s h o u l d   ` m i s s i n g   v a l u e `   i n d i c a t e   n o   v a l u e   o r   j u s t   u s e   e m p t y   t e x t   " " ?� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   JSON conversion   � ���     J S O N   c o n v e r s i o n� ��� l     ��������  ��  ��  � ��� i  . 1��� I     ����
�� .Web:FJSNnull���     ****� o      ���� 0 
jsonobject 
jsonObject� �����
�� 
EWSp� |����������  ��  � o      ���� "0 isprettyprinted isPrettyPrinted��  � l     ������ m      ��
�� boovfals��  ��  ��  � Q     ����� k    ��� ��� Z    ������ n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    	���� "0 isprettyprinted isPrettyPrinted� ���� m   	 
�� ��� " e x t r a   w h i t e   s p a c e��  ��  � o    ���� 0 _supportlib _supportLib� r    ��� n   ��� o    ���� 80 nsjsonwritingprettyprinted NSJSONWritingPrettyPrinted� m    ��
�� misccura� o      ���� 0 writeoptions writeOptions��  � r    ��� m    ����  � o      ���� 0 writeoptions writeOptions� ��� Z    5������� H    &�� l   %������ n   %��� I     %������� (0 isvalidjsonobject_ isValidJSONObject_� ���� o     !���� 0 
jsonobject 
jsonObject��  ��  � n    ��� o     ���� *0 nsjsonserialization NSJSONSerialization� m    ��
�� misccura��  ��  � R   ) 1����
�� .ascrerr ****      � ****� m   / 0�� ��� z C a n  t   c o n v e r t   o b j e c t   t o   J S O N   ( f o u n d   u n s u p p o r t e d   o b j e c t   t y p e ) .� ����
�� 
errn� m   + ,�����Y� �����
�� 
erob� o   - .���� 0 
jsonobject 
jsonObject��  ��  ��  � ��� r   6 O��� n  6 @��� I   9 @������� F0 !datawithjsonobject_options_error_ !dataWithJSONObject_options_error_� ��� o   9 :���� 0 
jsonobject 
jsonObject� ��� o   : ;���� 0 writeoptions writeOptions� ���� l  ; <������ m   ; <��
�� 
obj ��  ��  ��  ��  � n  6 9� � o   7 9���� *0 nsjsonserialization NSJSONSerialization  m   6 7��
�� misccura� J        o      ���� 0 thedata theData �� o      ���� 0 theerror theError��  �  Z  P l���� =  P S	
	 o   P Q���� 0 thedata theData
 m   Q R��
�� 
msng R   V h��
�� .ascrerr ****      � **** b   \ g b   \ c m   \ ] � : C a n  t   c o n v e r t   o b j e c t   t o   J S O N ( n  ] b I   ^ b�������� ,0 localizeddescription localizedDescription��  ��   o   ] ^���� 0 theerror theError m   c f �  ) . ��
�� 
errn m   X Y�����Y ����
�� 
erob o   Z [���� 0 
jsonobject 
jsonObject��  ��  ��   �� L   m � c   m � l  m ����� n  m �  I   v ���!���� 00 initwithdata_encoding_ initWithData_encoding_! "#" o   v w���� 0 thedata theData# $��$ l  w |%����% n  w |&'& o   x |���� ,0 nsutf8stringencoding NSUTF8StringEncoding' m   w x��
�� misccura��  ��  ��  ��    n  m v()( I   r v�������� 	0 alloc  ��  ��  ) n  m r*+* o   n r���� 0 nsstring NSString+ m   m n��
�� misccura��  ��   m   � ���
�� 
ctxt��  � R      ��,-
�� .ascrerr ****      � ****, o      �� 0 etext eText- �~./
�~ 
errn. o      �}�} 0 enumber eNumber/ �|01
�| 
erob0 o      �{�{ 0 efrom eFrom1 �z2�y
�z 
errt2 o      �x�x 
0 eto eTo�y  � I   � ��w3�v�w 
0 _error  3 454 m   � �66 �77  f o r m a t   J S O N5 898 o   � ��u�u 0 etext eText9 :;: o   � ��t�t 0 enumber eNumber; <=< o   � ��s�s 0 efrom eFrom= >�r> o   � ��q�q 
0 eto eTo�r  �v  � ?@? l     �p�o�n�p  �o  �n  @ ABA l     �m�l�k�m  �l  �k  B CDC i  2 5EFE I     �jGH
�j .Web:PJSNnull���     ctxtG o      �i�i 0 jsontext jsonTextH �hI�g
�h 
FragI |�f�eJ�dK�f  �e  J o      �c�c *0 arefragmentsallowed areFragmentsAllowed�d  K l     L�b�aL m      �`
�` boovfals�b  �a  �g  F Q     �MNOM k    �PP QRQ r    STS n   UVU I    �_W�^�_ "0 astextparameter asTextParameterW XYX o    	�]�] 0 jsontext jsonTextY Z�\Z m   	 
[[ �\\  �\  �^  V o    �[�[ 0 _supportlib _supportLibT o      �Z�Z 0 jsontext jsonTextR ]^] Z    *_`�Ya_ n   bcb I    �Xd�W�X (0 asbooleanparameter asBooleanParameterd efe o    �V�V *0 arefragmentsallowed areFragmentsAllowedf g�Ug m    hh �ii $ a l l o w i n g   f r a g m e n t s�U  �W  c o    �T�T 0 _supportlib _supportLib` r    $jkj n   "lml o     "�S�S :0 nsjsonreadingallowfragments NSJSONReadingAllowFragmentsm m     �R
�R misccurak o      �Q�Q 0 readoptions readOptions�Y  a r   ' *non m   ' (�P�P  o o      �O�O 0 readoptions readOptions^ pqp r   + <rsr n  + :tut I   3 :�Nv�M�N (0 datausingencoding_ dataUsingEncoding_v w�Lw l  3 6x�K�Jx n  3 6yzy o   4 6�I�I ,0 nsutf8stringencoding NSUTF8StringEncodingz m   3 4�H
�H misccura�K  �J  �L  �M  u l  + 3{�G�F{ n  + 3|}| I   . 3�E~�D�E &0 stringwithstring_ stringWithString_~ �C o   . /�B�B 0 jsontext jsonText�C  �D  } n  + .��� o   , .�A�A 0 nsstring NSString� m   + ,�@
�@ misccura�G  �F  s o      �?�? 0 thedata theDataq ��� r   = V��� n  = G��� I   @ G�>��=�> F0 !jsonobjectwithdata_options_error_ !JSONObjectWithData_options_error_� ��� o   @ A�<�< 0 thedata theData� ��� o   A B�;�; 0 readoptions readOptions� ��:� l  B C��9�8� m   B C�7
�7 
obj �9  �8  �:  �=  � n  = @��� o   > @�6�6 *0 nsjsonserialization NSJSONSerialization� m   = >�5
�5 misccura� J      �� ��� o      �4�4 0 
jsonobject 
jsonObject� ��3� o      �2�2 0 theerror theError�3  � ��� Z  W {���1�0� =  W Z��� o   W X�/�/ 0 
jsonobject 
jsonObject� m   X Y�.
�. 
msng� R   ] w�-��
�- .ascrerr ****      � ****� b   i v��� b   i r��� m   i l�� ���   N o t   v a l i d   J S O N   (� n  l q��� I   m q�,�+�*�, ,0 localizeddescription localizedDescription�+  �*  � o   l m�)�) 0 theerror theError� m   r u�� ���  ) .� �(��
�( 
errn� m   _ b�'�'�Y� �&��%
�& 
erob� o   e f�$�$ 0 jsontext jsonText�%  �1  �0  � ��#� L   | ��� c   | ���� o   | }�"�" 0 
jsonobject 
jsonObject� m   } ��!
�! 
****�#  N R      � ��
�  .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  O I   � ����� 
0 _error  � ��� m   � ��� ���  p a r s e   J S O N� ��� o   � ��� 0 etext eText� ��� o   � ��� 0 enumber eNumber� ��� o   � ��� 0 efrom eFrom� ��� o   � ��� 
0 eto eTo�  �  D ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     �
���
  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �	���	  �   HTTP dispatch   � ���    H T T P   d i s p a t c h� ��� l     ����  �  �  � ��� i  6 9��� I     ���
� .Web:ReqHnull��� ��� ctxt� |������  �  � o      �� 0 
httpmethod 
httpMethod�  � l     �� ��� m      �� ���  G E T�   ��  � ����
�� 
Dest� o      ���� 0 theurl theURL� ����
�� 
Head� |����������  ��  � o      ���� 0 headerslist headersList��  � J      ����  � ����
�� 
Body� |����������  ��  � o      ���� 0 bodydata bodyData��  � l     ������ m      ��
�� 
msng��  ��  � �����
�� 
Type� |����������  ��  � o      ���� $0 responsebodytype responseBodyType��  � l     ������ m      ��
�� 
ctxt��  ��  ��  � k      �� ��� l     ������  �NH Q. if responseBodyType is `text`, add appropriate content negotiation header automatically? (bear in mind that markup-based formats such as HTTP may have their own ideas about encoding, e.g. an HTML document may include its own content-type header while an inadequately configured server claims a completely different encoding)   � ����   Q .   i f   r e s p o n s e B o d y T y p e   i s   ` t e x t ` ,   a d d   a p p r o p r i a t e   c o n t e n t   n e g o t i a t i o n   h e a d e r   a u t o m a t i c a l l y ?   ( b e a r   i n   m i n d   t h a t   m a r k u p - b a s e d   f o r m a t s   s u c h   a s   H T T P   m a y   h a v e   t h e i r   o w n   i d e a s   a b o u t   e n c o d i n g ,   e . g .   a n   H T M L   d o c u m e n t   m a y   i n c l u d e   i t s   o w n   c o n t e n t - t y p e   h e a d e r   w h i l e   a n   i n a d e q u a t e l y   c o n f i g u r e d   s e r v e r   c l a i m s   a   c o m p l e t e l y   d i f f e r e n t   e n c o d i n g )� ��� l     ��������  ��  ��  � ���� l     ������  �?9 note that TextLib will need to provide `convert text to data` and `convert data to text` handlers for converting between `utxt` and `rdat` given an explicit encoding (see also FileLib, which already provides some encoding support, but as constants, not fuzzy name strings, which isn't good for portability/reuse)   � ���r   n o t e   t h a t   T e x t L i b   w i l l   n e e d   t o   p r o v i d e   ` c o n v e r t   t e x t   t o   d a t a `   a n d   ` c o n v e r t   d a t a   t o   t e x t `   h a n d l e r s   f o r   c o n v e r t i n g   b e t w e e n   ` u t x t `   a n d   ` r d a t `   g i v e n   a n   e x p l i c i t   e n c o d i n g   ( s e e   a l s o   F i l e L i b ,   w h i c h   a l r e a d y   p r o v i d e s   s o m e   e n c o d i n g   s u p p o r t ,   b u t   a s   c o n s t a n t s ,   n o t   f u z z y   n a m e   s t r i n g s ,   w h i c h   i s n ' t   g o o d   f o r   p o r t a b i l i t y / r e u s e )��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       �������� ��  � ������������������������
�� 
pimr�� 0 _supportlib _supportLib�� 
0 _error  
�� .Web:SplUnull���     ctxt
�� .Web:JoiUnull���     ****
�� .Web:EscUnull���     ctxt
�� .Web:UneUnull���     ctxt
�� .Web:SplQnull���     ctxt
�� .Web:JoiQnull���     ctxt
�� .Web:FJSNnull���     ****
�� .Web:PJSNnull���     ctxt
�� .Web:ReqHnull��� ��� ctxt� ����    ��	��
�� 
cobj	 

   �� 
�� 
frmk��  �    �� *
�� 
scpt� �� 4�������� 
0 _error  �� ����   ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��   ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo  D������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ � �� b������
�� .Web:SplUnull���     ctxt�� 0 urltext urlText��   ������������ 0 urltext urlText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo  r���� ������ "0 astextparameter asTextParameter�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� % b  ��l+ E�OPW X  *䡢���+ � �� �������
�� .Web:JoiUnull���     ****�� 0 	urlrecord 	urlRecord�� ����
�� 
Base {���� ��� 0 baseurl baseURL��  ��   �������������� 0 	urlrecord 	urlRecord�� 0 baseurl baseURL�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo 	 ��� ����� ������� &0 asrecordparameter asRecordParameter�� "0 astextparameter asTextParameter�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� 3 "b  ��l+ E�Ob  ��l+ E�OPW X  *梣���+   �� �������
�� .Web:EscUnull���     ctxt�� 0 urltext urlText��   ����������� 0 urltext urlText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom� 
0 eto eTo  ��~�} �|�{�~ "0 astextparameter asTextParameter�} 0 etext eText �z�y
�z 
errn�y 0 enumber eNumber �x�w
�x 
erob�w 0 efrom eFrom �v�u�t
�v 
errt�u 
0 eto eTo�t  �| �{ 
0 _error  �� % b  ��l+ E�OPW X  *䡢���+  �s�r�q �p
�s .Web:UneUnull���     ctxt�r 0 urltext urlText�q   �o�n�m�l�k�o 0 urltext urlText�n 0 etext eText�m 0 enumber eNumber�l 0 efrom eFrom�k 
0 eto eTo   �j�i!-�h�g�j "0 astextparameter asTextParameter�i 0 etext eText! �f�e"
�f 
errn�e 0 enumber eNumber" �d�c#
�d 
erob�c 0 efrom eFrom# �b�a�`
�b 
errt�a 
0 eto eTo�`  �h �g 
0 _error  �p % b  ��l+ E�OPW X  *䡢���+  �_W�^�]$%�\
�_ .Web:SplQnull���     ctxt�^ 0 	querytext 	queryText�]  $ �[�Z�Y�X�W�[ 0 	querytext 	queryText�Z 0 etext eText�Y 0 enumber eNumber�X 0 efrom eFrom�W 
0 eto eTo% g�V�U&t�T�S�V "0 astextparameter asTextParameter�U 0 etext eText& �R�Q'
�R 
errn�Q 0 enumber eNumber' �P�O(
�P 
erob�O 0 efrom eFrom( �N�M�L
�N 
errt�M 
0 eto eTo�L  �T �S 
0 _error  �\ % b  ��l+ E�OPW X  *䡢���+  �K��J�I)*�H
�K .Web:JoiQnull���     ctxt�J 0 	querylist 	queryList�I  ) �G�F�E�D�C�G 0 	querylist 	queryList�F 0 etext eText�E 0 enumber eNumber�D 0 efrom eFrom�C 
0 eto eTo* ��B�A+��@�?�B "0 aslistparameter asListParameter�A 0 etext eText+ �>�=,
�> 
errn�= 0 enumber eNumber, �<�;-
�< 
erob�; 0 efrom eFrom- �:�9�8
�: 
errt�9 
0 eto eTo�8  �@ �? 
0 _error  �H % b  ��l+ E�OPW X  *䡢���+  �7��6�5./�4
�7 .Web:FJSNnull���     ****�6 0 
jsonobject 
jsonObject�5 �30�2
�3 
EWSp0 {�1�0�/�1 "0 isprettyprinted isPrettyPrinted�0  
�/ boovfals�2  . 	�.�-�,�+�*�)�(�'�&�. 0 
jsonobject 
jsonObject�- "0 isprettyprinted isPrettyPrinted�, 0 writeoptions writeOptions�+ 0 thedata theData�* 0 theerror theError�) 0 etext eText�( 0 enumber eNumber�' 0 efrom eFrom�& 
0 eto eTo/ ��%�$�#�"�!� ���������������16���% (0 asbooleanparameter asBooleanParameter
�$ misccura�# 80 nsjsonwritingprettyprinted NSJSONWritingPrettyPrinted�" *0 nsjsonserialization NSJSONSerialization�! (0 isvalidjsonobject_ isValidJSONObject_
�  
errn��Y
� 
erob� 
� 
obj � F0 !datawithjsonobject_options_error_ !dataWithJSONObject_options_error_
� 
cobj
� 
msng� ,0 localizeddescription localizedDescription� 0 nsstring NSString� 	0 alloc  � ,0 nsutf8stringencoding NSUTF8StringEncoding� 00 initwithdata_encoding_ initWithData_encoding_
� 
ctxt� 0 etext eText1 ��2
� 
errn� 0 enumber eNumber2 ��3
� 
erob� 0 efrom eFrom3 ��
�	
� 
errt�
 
0 eto eTo�	  � � 
0 _error  �4 � �b  ��l+  
��,E�Y jE�O��,�k+  )�����Y hO��,���m+ E[�k/E�Z[�l/E�ZO��  )�����j+ %a %Y hO�a ,j+ ��a ,l+ a &W X  *a ����a +  �F��45�
� .Web:PJSNnull���     ctxt� 0 jsontext jsonText� �6�
� 
Frag6 {��� � *0 arefragmentsallowed areFragmentsAllowed�  
�  boovfals�  4 
���������������������� 0 jsontext jsonText�� *0 arefragmentsallowed areFragmentsAllowed�� 0 readoptions readOptions�� 0 thedata theData�� 0 
jsonobject 
jsonObject�� 0 theerror theError�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo5 [��h����������������������������������������7������� "0 astextparameter asTextParameter�� (0 asbooleanparameter asBooleanParameter
�� misccura�� :0 nsjsonreadingallowfragments NSJSONReadingAllowFragments�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� ,0 nsutf8stringencoding NSUTF8StringEncoding�� (0 datausingencoding_ dataUsingEncoding_�� *0 nsjsonserialization NSJSONSerialization
�� 
obj �� F0 !jsonobjectwithdata_options_error_ !JSONObjectWithData_options_error_
�� 
cobj
�� 
msng
�� 
errn���Y
�� 
erob�� �� ,0 localizeddescription localizedDescription
�� 
****�� 0 etext eText7 ����8
�� 
errn�� 0 enumber eNumber8 ����9
�� 
erob�� 0 efrom eFrom9 ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � � �b  ��l+ E�Ob  ��l+  
��,E�Y jE�O��,�k+ ��,k+ 	E�O��,���m+ E[�k/E�Z[�l/E�ZO��  )�a a �a a �j+ %a %Y hO�a &W X  *a ����a +  �������:;��
�� .Web:ReqHnull��� ��� ctxt�� {������� 0 
httpmethod 
httpMethod��  �� ����<
�� 
Dest�� 0 theurl theURL< ��=>
�� 
Head= {�������� 0 headerslist headersList��  ��  > ��?@
�� 
Body? {�������� 0 bodydata bodyData��  
�� 
msng@ ��A��
�� 
TypeA {�������� $0 responsebodytype responseBodyType��  
�� 
ctxt��  : ������������ 0 
httpmethod 
httpMethod�� 0 theurl theURL�� 0 headerslist headersList�� 0 bodydata bodyData�� $0 responsebodytype responseBodyType;  �� h ascr  ��ޭ