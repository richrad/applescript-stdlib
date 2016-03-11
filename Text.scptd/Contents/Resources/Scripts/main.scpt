FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� Text -- commonly-used text processing commands

Notes: 

- When matching text item delimiters in text value, AppleScript uses the current scope's existing considering/ignoring case, diacriticals, hyphens, punctuation, white space and numeric strings settings; thus, wrapping a `search text` command in different considering/ignoring blocks can produce different results. For example, `search text "fud" for "F" will normally match the first character since AppleScript uses case-insensitive matching by default, whereas enclosing it in a `considering case` block will cause the same command to return zero matches. Conversely, `search text "f ud" for "fu"` will normally return zero matches as AppleScript considers white space by default, but when enclosed in an `ignoring white space` block will match the first three characters: "f u". This is how AppleScript is designed to work, but users need to be reminded of this as considering/ignoring blocks affect ALL script handlers called within that block, including nested calls (and all to any osax and application handlers that understand considering/ignoring attributes).

- Unlike AS text values, which preserve original Unicode normalization but ignore differences in form when comparing and counting, NSString and NSRegularExpression don't ignore normalization differences when comparing for equality. Therefore, handlers such as `search text`, `split text`, etc. that perform comparison operations on/using these Cocoa classes must normalize their input and pattern text first. (Be aware that this means that these commands may output text that uses different normalization form to input text; this shouldn't affect AppleScript itself, but might be a consideration when using that text elsewhere, e.g. in text files or scriptable apps.)


TO DO:

- decide if predefined considering/ignoring options in `search text`, etc. should consider or ignore diacriticals and numeric strings; once decided, use same combinations for List library's text comparator for consistency? (currently Text library's `case [in]sensitivity` options consider diacriticals for equality whereas List library ignores them for ordering)


- what about `normalize text` command that wraps NSString's stringByFoldingWithOptions:locale:? (e.g. for removing diacriticals); also incorporate unicode normalization into this rather than having separate precompose/decompose commands; also merge the `normalize line breaks` command's functionality in it. 



- should `format text` support "\\n", "\\t", "\\U", etc. (yes, even if it means it's a superset of `search text` templates, though even those could be extended by routing through this first, in which case `using` parameter should be optional)? how should backslashed characters that are non-special be treated? (note that the template syntax is designed to be same as that used by `search text`, which uses NSRegularExpression's template syntax); need to give some thought to this, and whether a different escape character (^) should be used throughout to avoid need for double backslashing (since AS already uses backslash as escape character in text literals), which is hard to read and error prone (downside is portability, as backslash escaping is already standard in regexps); note that caching of recently (last only?) converted format texts could be provided (though not using NSDictionary)

	- probably best to use "^n", "^t", "^r", "^x12", "^u1234", "^U12345678", "^1"..."^9", "^^"; while incompatible with `search text` templates, it would make `format text` much more useful (note: need to decide on standard escape character: `\` has disadvantage of requiring double escaping in AS string literals, but is already used by standard regexp syntax [which cannot be changed] and familiar to users; `^` or ``` would avoid need for double quoting, but are non-standard); one option might be to use `\` in `search text`, but allow a custom escape char to be specified in `format text` (probably best to pick one - e.g. `^` - and provide an optional Boolean parameter for choosing between that and traditional backslash)


- fix inconsistency: `search text`'s `for` parameter doesn't allow list of text but `split text`'s `using` parameter does, even though both commands are supposed to support same matching options for consistency

- should regexps use NSRegularExpressionAnchorsMatchLines flag as standard (i.e. "^" and "$" would always match per-line, and "\A" and "\Z" would be used to match start and end of text)? Given that users will frequently need to include "(?i)" flag to match case-insensitively, it may be as well to leave them to include `m` flag as well. OTOH, `(?-ismx)` can be used to turn options off as well as on; and since AS favors convenience (e.g. case-insensitivity) over formalism it may be worth having `i` and possibly `s` and/or `m` enabled by default, and just make sure these defaults are clearly documented.

- should line break normalization (in `normalize text` and `join paragraphs`) also recognize `Unicode line break`, `Unicode paragraph break` constants?

- need to decide exactly what constitutes a line break in `normalize text`, and make sure both paragraph element and pattern based splitting are consistent (e.g. what about form feeds and Unicode line/paragraph breaks?)

     � 	 	)p   T e x t   - -   c o m m o n l y - u s e d   t e x t   p r o c e s s i n g   c o m m a n d s 
 
 N o t e s :   
 
 -   W h e n   m a t c h i n g   t e x t   i t e m   d e l i m i t e r s   i n   t e x t   v a l u e ,   A p p l e S c r i p t   u s e s   t h e   c u r r e n t   s c o p e ' s   e x i s t i n g   c o n s i d e r i n g / i g n o r i n g   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n ,   w h i t e   s p a c e   a n d   n u m e r i c   s t r i n g s   s e t t i n g s ;   t h u s ,   w r a p p i n g   a   ` s e a r c h   t e x t `   c o m m a n d   i n   d i f f e r e n t   c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n   p r o d u c e   d i f f e r e n t   r e s u l t s .   F o r   e x a m p l e ,   ` s e a r c h   t e x t   " f u d "   f o r   " F "   w i l l   n o r m a l l y   m a t c h   t h e   f i r s t   c h a r a c t e r   s i n c e   A p p l e S c r i p t   u s e s   c a s e - i n s e n s i t i v e   m a t c h i n g   b y   d e f a u l t ,   w h e r e a s   e n c l o s i n g   i t   i n   a   ` c o n s i d e r i n g   c a s e `   b l o c k   w i l l   c a u s e   t h e   s a m e   c o m m a n d   t o   r e t u r n   z e r o   m a t c h e s .   C o n v e r s e l y ,   ` s e a r c h   t e x t   " f   u d "   f o r   " f u " `   w i l l   n o r m a l l y   r e t u r n   z e r o   m a t c h e s   a s   A p p l e S c r i p t   c o n s i d e r s   w h i t e   s p a c e   b y   d e f a u l t ,   b u t   w h e n   e n c l o s e d   i n   a n   ` i g n o r i n g   w h i t e   s p a c e `   b l o c k   w i l l   m a t c h   t h e   f i r s t   t h r e e   c h a r a c t e r s :   " f   u " .   T h i s   i s   h o w   A p p l e S c r i p t   i s   d e s i g n e d   t o   w o r k ,   b u t   u s e r s   n e e d   t o   b e   r e m i n d e d   o f   t h i s   a s   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a f f e c t   A L L   s c r i p t   h a n d l e r s   c a l l e d   w i t h i n   t h a t   b l o c k ,   i n c l u d i n g   n e s t e d   c a l l s   ( a n d   a l l   t o   a n y   o s a x   a n d   a p p l i c a t i o n   h a n d l e r s   t h a t   u n d e r s t a n d   c o n s i d e r i n g / i g n o r i n g   a t t r i b u t e s ) . 
 
 -   U n l i k e   A S   t e x t   v a l u e s ,   w h i c h   p r e s e r v e   o r i g i n a l   U n i c o d e   n o r m a l i z a t i o n   b u t   i g n o r e   d i f f e r e n c e s   i n   f o r m   w h e n   c o m p a r i n g   a n d   c o u n t i n g ,   N S S t r i n g   a n d   N S R e g u l a r E x p r e s s i o n   d o n ' t   i g n o r e   n o r m a l i z a t i o n   d i f f e r e n c e s   w h e n   c o m p a r i n g   f o r   e q u a l i t y .   T h e r e f o r e ,   h a n d l e r s   s u c h   a s   ` s e a r c h   t e x t ` ,   ` s p l i t   t e x t ` ,   e t c .   t h a t   p e r f o r m   c o m p a r i s o n   o p e r a t i o n s   o n / u s i n g   t h e s e   C o c o a   c l a s s e s   m u s t   n o r m a l i z e   t h e i r   i n p u t   a n d   p a t t e r n   t e x t   f i r s t .   ( B e   a w a r e   t h a t   t h i s   m e a n s   t h a t   t h e s e   c o m m a n d s   m a y   o u t p u t   t e x t   t h a t   u s e s   d i f f e r e n t   n o r m a l i z a t i o n   f o r m   t o   i n p u t   t e x t ;   t h i s   s h o u l d n ' t   a f f e c t   A p p l e S c r i p t   i t s e l f ,   b u t   m i g h t   b e   a   c o n s i d e r a t i o n   w h e n   u s i n g   t h a t   t e x t   e l s e w h e r e ,   e . g .   i n   t e x t   f i l e s   o r   s c r i p t a b l e   a p p s . ) 
 
 
 T O   D O : 
 
 -   d e c i d e   i f   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   i n   ` s e a r c h   t e x t ` ,   e t c .   s h o u l d   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s   a n d   n u m e r i c   s t r i n g s ;   o n c e   d e c i d e d ,   u s e   s a m e   c o m b i n a t i o n s   f o r   L i s t   l i b r a r y ' s   t e x t   c o m p a r a t o r   f o r   c o n s i s t e n c y ?   ( c u r r e n t l y   T e x t   l i b r a r y ' s   ` c a s e   [ i n ] s e n s i t i v i t y `   o p t i o n s   c o n s i d e r   d i a c r i t i c a l s   f o r   e q u a l i t y   w h e r e a s   L i s t   l i b r a r y   i g n o r e s   t h e m   f o r   o r d e r i n g ) 
 
 
 -   w h a t   a b o u t   ` n o r m a l i z e   t e x t `   c o m m a n d   t h a t   w r a p s   N S S t r i n g ' s   s t r i n g B y F o l d i n g W i t h O p t i o n s : l o c a l e : ?   ( e . g .   f o r   r e m o v i n g   d i a c r i t i c a l s ) ;   a l s o   i n c o r p o r a t e   u n i c o d e   n o r m a l i z a t i o n   i n t o   t h i s   r a t h e r   t h a n   h a v i n g   s e p a r a t e   p r e c o m p o s e / d e c o m p o s e   c o m m a n d s ;   a l s o   m e r g e   t h e   ` n o r m a l i z e   l i n e   b r e a k s `   c o m m a n d ' s   f u n c t i o n a l i t y   i n   i t .   
 
 
 
 -   s h o u l d   ` f o r m a t   t e x t `   s u p p o r t   " \ \ n " ,   " \ \ t " ,   " \ \ U " ,   e t c .   ( y e s ,   e v e n   i f   i t   m e a n s   i t ' s   a   s u p e r s e t   o f   ` s e a r c h   t e x t `   t e m p l a t e s ,   t h o u g h   e v e n   t h o s e   c o u l d   b e   e x t e n d e d   b y   r o u t i n g   t h r o u g h   t h i s   f i r s t ,   i n   w h i c h   c a s e   ` u s i n g `   p a r a m e t e r   s h o u l d   b e   o p t i o n a l ) ?   h o w   s h o u l d   b a c k s l a s h e d   c h a r a c t e r s   t h a t   a r e   n o n - s p e c i a l   b e   t r e a t e d ?   ( n o t e   t h a t   t h e   t e m p l a t e   s y n t a x   i s   d e s i g n e d   t o   b e   s a m e   a s   t h a t   u s e d   b y   ` s e a r c h   t e x t ` ,   w h i c h   u s e s   N S R e g u l a r E x p r e s s i o n ' s   t e m p l a t e   s y n t a x ) ;   n e e d   t o   g i v e   s o m e   t h o u g h t   t o   t h i s ,   a n d   w h e t h e r   a   d i f f e r e n t   e s c a p e   c h a r a c t e r   ( ^ )   s h o u l d   b e   u s e d   t h r o u g h o u t   t o   a v o i d   n e e d   f o r   d o u b l e   b a c k s l a s h i n g   ( s i n c e   A S   a l r e a d y   u s e s   b a c k s l a s h   a s   e s c a p e   c h a r a c t e r   i n   t e x t   l i t e r a l s ) ,   w h i c h   i s   h a r d   t o   r e a d   a n d   e r r o r   p r o n e   ( d o w n s i d e   i s   p o r t a b i l i t y ,   a s   b a c k s l a s h   e s c a p i n g   i s   a l r e a d y   s t a n d a r d   i n   r e g e x p s ) ;   n o t e   t h a t   c a c h i n g   o f   r e c e n t l y   ( l a s t   o n l y ? )   c o n v e r t e d   f o r m a t   t e x t s   c o u l d   b e   p r o v i d e d   ( t h o u g h   n o t   u s i n g   N S D i c t i o n a r y ) 
 
 	 -   p r o b a b l y   b e s t   t o   u s e   " ^ n " ,   " ^ t " ,   " ^ r " ,   " ^ x 1 2 " ,   " ^ u 1 2 3 4 " ,   " ^ U 1 2 3 4 5 6 7 8 " ,   " ^ 1 " . . . " ^ 9 " ,   " ^ ^ " ;   w h i l e   i n c o m p a t i b l e   w i t h   ` s e a r c h   t e x t `   t e m p l a t e s ,   i t   w o u l d   m a k e   ` f o r m a t   t e x t `   m u c h   m o r e   u s e f u l   ( n o t e :   n e e d   t o   d e c i d e   o n   s t a n d a r d   e s c a p e   c h a r a c t e r :   ` \ `   h a s   d i s a d v a n t a g e   o f   r e q u i r i n g   d o u b l e   e s c a p i n g   i n   A S   s t r i n g   l i t e r a l s ,   b u t   i s   a l r e a d y   u s e d   b y   s t a n d a r d   r e g e x p   s y n t a x   [ w h i c h   c a n n o t   b e   c h a n g e d ]   a n d   f a m i l i a r   t o   u s e r s ;   ` ^ `   o r   ` ` `   w o u l d   a v o i d   n e e d   f o r   d o u b l e   q u o t i n g ,   b u t   a r e   n o n - s t a n d a r d ) ;   o n e   o p t i o n   m i g h t   b e   t o   u s e   ` \ `   i n   ` s e a r c h   t e x t ` ,   b u t   a l l o w   a   c u s t o m   e s c a p e   c h a r   t o   b e   s p e c i f i e d   i n   ` f o r m a t   t e x t `   ( p r o b a b l y   b e s t   t o   p i c k   o n e   -   e . g .   ` ^ `   -   a n d   p r o v i d e   a n   o p t i o n a l   B o o l e a n   p a r a m e t e r   f o r   c h o o s i n g   b e t w e e n   t h a t   a n d   t r a d i t i o n a l   b a c k s l a s h ) 
 
 
 -   f i x   i n c o n s i s t e n c y :   ` s e a r c h   t e x t ` ' s   ` f o r `   p a r a m e t e r   d o e s n ' t   a l l o w   l i s t   o f   t e x t   b u t   ` s p l i t   t e x t ` ' s   ` u s i n g `   p a r a m e t e r   d o e s ,   e v e n   t h o u g h   b o t h   c o m m a n d s   a r e   s u p p o s e d   t o   s u p p o r t   s a m e   m a t c h i n g   o p t i o n s   f o r   c o n s i s t e n c y 
 
 -   s h o u l d   r e g e x p s   u s e   N S R e g u l a r E x p r e s s i o n A n c h o r s M a t c h L i n e s   f l a g   a s   s t a n d a r d   ( i . e .   " ^ "   a n d   " $ "   w o u l d   a l w a y s   m a t c h   p e r - l i n e ,   a n d   " \ A "   a n d   " \ Z "   w o u l d   b e   u s e d   t o   m a t c h   s t a r t   a n d   e n d   o f   t e x t ) ?   G i v e n   t h a t   u s e r s   w i l l   f r e q u e n t l y   n e e d   t o   i n c l u d e   " ( ? i ) "   f l a g   t o   m a t c h   c a s e - i n s e n s i t i v e l y ,   i t   m a y   b e   a s   w e l l   t o   l e a v e   t h e m   t o   i n c l u d e   ` m `   f l a g   a s   w e l l .   O T O H ,   ` ( ? - i s m x ) `   c a n   b e   u s e d   t o   t u r n   o p t i o n s   o f f   a s   w e l l   a s   o n ;   a n d   s i n c e   A S   f a v o r s   c o n v e n i e n c e   ( e . g .   c a s e - i n s e n s i t i v i t y )   o v e r   f o r m a l i s m   i t   m a y   b e   w o r t h   h a v i n g   ` i `   a n d   p o s s i b l y   ` s `   a n d / o r   ` m `   e n a b l e d   b y   d e f a u l t ,   a n d   j u s t   m a k e   s u r e   t h e s e   d e f a u l t s   a r e   c l e a r l y   d o c u m e n t e d . 
 
 -   s h o u l d   l i n e   b r e a k   n o r m a l i z a t i o n   ( i n   ` n o r m a l i z e   t e x t `   a n d   ` j o i n   p a r a g r a p h s ` )   a l s o   r e c o g n i z e   ` U n i c o d e   l i n e   b r e a k ` ,   ` U n i c o d e   p a r a g r a p h   b r e a k `   c o n s t a n t s ? 
 
 -   n e e d   t o   d e c i d e   e x a c t l y   w h a t   c o n s t i t u t e s   a   l i n e   b r e a k   i n   ` n o r m a l i z e   t e x t ` ,   a n d   m a k e   s u r e   b o t h   p a r a g r a p h   e l e m e n t   a n d   p a t t e r n   b a s e d   s p l i t t i n g   a r e   c o n s i s t e n t   ( e . g .   w h a t   a b o u t   f o r m   f e e d s   a n d   U n i c o d e   l i n e / p a r a g r a p h   b r e a k s ? ) 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      record types     �      r e c o r d   t y p e s     !   l     ��������  ��  ��   !  " # " j    �� $�� (0 _unmatchedtexttype _UnmatchedTextType $ m    ��
�� 
TxtU #  % & % j    �� '�� $0 _matchedtexttype _MatchedTextType ' m    ��
�� 
TxtM &  ( ) ( j    �� *�� &0 _matchedgrouptype _MatchedGroupType * m    ��
�� 
TxtG )  + , + l     ��������  ��  ��   ,  - . - l     ��������  ��  ��   .  / 0 / l     �� 1 2��   1 J D--------------------------------------------------------------------    2 � 3 3 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 0  4 5 4 l     �� 6 7��   6   support    7 � 8 8    s u p p o r t 5  9 : 9 l     ��������  ��  ��   :  ; < ; l      = > ? = j    �� @�� 0 _support   @ N     A A 4    �� B
�� 
scpt B m     C C � D D  T y p e S u p p o r t > "  used for parameter checking    ? � E E 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g <  F G F l     ��������  ��  ��   G  H I H l     ��������  ��  ��   I  J K J i    L M L I      �� N���� 
0 _error   N  O P O o      ���� 0 handlername handlerName P  Q R Q o      ���� 0 etext eText R  S T S o      ���� 0 enumber eNumber T  U V U o      ���� 0 efrom eFrom V  W�� W o      ���� 
0 eto eTo��  ��   M n     X Y X I    �� Z���� &0 throwcommanderror throwCommandError Z  [ \ [ m     ] ] � ^ ^  T e x t \  _ ` _ o    ���� 0 handlername handlerName `  a b a o    ���� 0 etext eText b  c d c o    	���� 0 enumber eNumber d  e f e o   	 
���� 0 efrom eFrom f  g�� g o   
 ���� 
0 eto eTo��  ��   Y o     ���� 0 _support   K  h i h l     ��������  ��  ��   i  j k j l     ��������  ��  ��   k  l m l i   " n o n I      �� p���� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter p  q r q o      ���� 0 patterntext patternText r  s�� s o      ���� 0 parametername parameterName��  ��   o l     t u v t L      w w n     x y x I    �� z���� @0 asnsregularexpressionparameter asNSRegularExpressionParameter z  { | { o    ���� 0 patterntext patternText |  } ~ } l 	   ����  l    ����� � [     � � � [     � � � [     � � � l   
 ����� � e    
 � � n   
 � � � o    	���� H0 "nsregularexpressioncaseinsensitive "NSRegularExpressionCaseInsensitive � m    ��
�� misccura��  ��   � l 	 
  ����� � l  
  ����� � e   
  � � n  
  � � � o    ���� L0 $nsregularexpressionanchorsmatchlines $NSRegularExpressionAnchorsMatchLines � m   
 ��
�� misccura��  ��  ��  ��   � l 	   ����� � l    ����� � e     � � n    � � � o    ���� Z0 +nsregularexpressiondotmatcheslineseparators +NSRegularExpressionDotMatchesLineSeparators � m    ��
�� misccura��  ��  ��  ��   � l 	   ����� � l    ����� � e     � � n    � � � o    ���� Z0 +nsregularexpressionuseunicodewordboundaries +NSRegularExpressionUseUnicodeWordBoundaries � m    ��
�� misccura��  ��  ��  ��  ��  ��  ��  ��   ~  ��� � m     � � � � �  f o r��  ��   y o     ���� 0 _support   u r l returns a regexp object with enhanced `\b` word boundary matching, plus `(?ism)` options enabled by default    v � � � �   r e t u r n s   a   r e g e x p   o b j e c t   w i t h   e n h a n c e d   ` \ b `   w o r d   b o u n d a r y   m a t c h i n g ,   p l u s   ` ( ? i s m ) `   o p t i o n s   e n a b l e d   b y   d e f a u l t m  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   Find and Replace Suite    � � � � .   F i n d   a n d   R e p l a c e   S u i t e �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   find pattern    � � � �    f i n d   p a t t e r n �  � � � l     ��������  ��  ��   �  � � � i  # & � � � I      �� ����� $0 _matchinforecord _matchInfoRecord �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ���� 0 
textoffset 
textOffset �  ��� � o      ���� 0 
recordtype 
recordType��  ��   � k     # � �  � � � r     
 � � � c      � � � l     ����� � n     � � � I    �� ���� *0 substringwithrange_ substringWithRange_ �  ��~ � o    �}�}  0 asocmatchrange asocMatchRange�~  �   � o     �|�| 0 
asocstring 
asocString��  ��   � m    �{
�{ 
ctxt � o      �z�z 0 	foundtext 	foundText �  � � � l    � � � � r     � � � [     � � � o    �y�y 0 
textoffset 
textOffset � l    ��x�w � n     � � � 1    �v
�v 
leng � o    �u�u 0 	foundtext 	foundText�x  �w   � o      �t�t  0 nexttextoffset nextTextOffset � : 4 calculate the start index of the next AS text range    � � � � h   c a l c u l a t e   t h e   s t a r t   i n d e x   o f   t h e   n e x t   A S   t e x t   r a n g e �  � � � l   �s � ��s   �
 note: record keys are identifiers, not keywords, as 1. library-defined keywords are a huge pain to use outside of `tell script...` blocks and 2. importing the library's terminology into the global namespace via `use script...` is an excellent way to create keyword conflicts; only the class value is a keyword since Script Editor/OSAKit don't correctly handle records that use non-typename values (e.g. `{class:"matched text",...}`), but this shouldn't impact usability as it's really only used for informational purposes    � � � �   n o t e :   r e c o r d   k e y s   a r e   i d e n t i f i e r s ,   n o t   k e y w o r d s ,   a s   1 .   l i b r a r y - d e f i n e d   k e y w o r d s   a r e   a   h u g e   p a i n   t o   u s e   o u t s i d e   o f   ` t e l l   s c r i p t . . . `   b l o c k s   a n d   2 .   i m p o r t i n g   t h e   l i b r a r y ' s   t e r m i n o l o g y   i n t o   t h e   g l o b a l   n a m e s p a c e   v i a   ` u s e   s c r i p t . . . `   i s   a n   e x c e l l e n t   w a y   t o   c r e a t e   k e y w o r d   c o n f l i c t s ;   o n l y   t h e   c l a s s   v a l u e   i s   a   k e y w o r d   s i n c e   S c r i p t   E d i t o r / O S A K i t   d o n ' t   c o r r e c t l y   h a n d l e   r e c o r d s   t h a t   u s e   n o n - t y p e n a m e   v a l u e s   ( e . g .   ` { c l a s s : " m a t c h e d   t e x t " , . . . } ` ) ,   b u t   t h i s   s h o u l d n ' t   i m p a c t   u s a b i l i t y   a s   i t ' s   r e a l l y   o n l y   u s e d   f o r   i n f o r m a t i o n a l   p u r p o s e s �  ��r � L    # � � J    " � �  � � � K     � � �q � �
�q 
pcls � o    �p�p 0 
recordtype 
recordType � �o � ��o 0 
startindex 
startIndex � o    �n�n 0 
textoffset 
textOffset � �m � ��m 0 endindex endIndex � \     � � � o    �l�l  0 nexttextoffset nextTextOffset � m    �k�k  � �j ��i�j 0 	foundtext 	foundText � o    �h�h 0 	foundtext 	foundText�i   �  ��g � o     �f�f  0 nexttextoffset nextTextOffset�g  �r   �  � � � l     �e�d�c�e  �d  �c   �  � � � l     �b�a�`�b  �a  �`   �  � � � i  ' * � � � I      �_ ��^�_ 0 _matchrecords _matchRecords �  � � � o      �]�] 0 
asocstring 
asocString �  � � � o      �\�\  0 asocmatchrange asocMatchRange �  � � � o      �[�[  0 asocstartindex asocStartIndex �  � � � o      �Z�Z 0 
textoffset 
textOffset �    o      �Y�Y (0 nonmatchrecordtype nonMatchRecordType �X o      �W�W "0 matchrecordtype matchRecordType�X  �^   � k     V  l     �V�V  TN important: NSString character indexes aren't guaranteed to be same as AS character indexes (AS sensibly counts glyphs but NSString only counts UTF16 codepoints, and a glyph may be composed of more than one codepoint), so reconstruct both non-matching and matching AS text values, and calculate accurate AS character ranges from those    ��   i m p o r t a n t :   N S S t r i n g   c h a r a c t e r   i n d e x e s   a r e n ' t   g u a r a n t e e d   t o   b e   s a m e   a s   A S   c h a r a c t e r   i n d e x e s   ( A S   s e n s i b l y   c o u n t s   g l y p h s   b u t   N S S t r i n g   o n l y   c o u n t s   U T F 1 6   c o d e p o i n t s ,   a n d   a   g l y p h   m a y   b e   c o m p o s e d   o f   m o r e   t h a n   o n e   c o d e p o i n t ) ,   s o   r e c o n s t r u c t   b o t h   n o n - m a t c h i n g   a n d   m a t c h i n g   A S   t e x t   v a l u e s ,   a n d   c a l c u l a t e   a c c u r a t e   A S   c h a r a c t e r   r a n g e s   f r o m   t h o s e 	
	 r      n     I    �U�T�S�U 0 location  �T  �S   o     �R�R  0 asocmatchrange asocMatchRange o      �Q�Q  0 asocmatchstart asocMatchStart
  r     [     o    	�P�P  0 asocmatchstart asocMatchStart l  	 �O�N n  	  I   
 �M�L�K�M 
0 length  �L  �K   o   	 
�J�J  0 asocmatchrange asocMatchRange�O  �N   o      �I�I 0 asocmatchend asocMatchEnd  r     K     �H�H 0 location   o    �G�G  0 asocstartindex asocStartIndex �F�E�F 
0 length   \     !  o    �D�D  0 asocmatchstart asocMatchStart! o    �C�C  0 asocstartindex asocStartIndex�E   o      �B�B &0 asocnonmatchrange asocNonMatchRange "#" r    5$%$ I      �A&�@�A $0 _matchinforecord _matchInfoRecord& '(' o    �?�? 0 
asocstring 
asocString( )*) o     �>�> &0 asocnonmatchrange asocNonMatchRange* +,+ o     !�=�= 0 
textoffset 
textOffset, -�<- o   ! "�;�; (0 nonmatchrecordtype nonMatchRecordType�<  �@  % J      .. /0/ o      �:�: 0 nonmatchinfo nonMatchInfo0 1�91 o      �8�8 0 
textoffset 
textOffset�9  # 232 r   6 N454 I      �76�6�7 $0 _matchinforecord _matchInfoRecord6 787 o   7 8�5�5 0 
asocstring 
asocString8 9:9 o   8 9�4�4  0 asocmatchrange asocMatchRange: ;<; o   9 :�3�3 0 
textoffset 
textOffset< =�2= o   : ;�1�1 "0 matchrecordtype matchRecordType�2  �6  5 J      >> ?@? o      �0�0 0 	matchinfo 	matchInfo@ A�/A o      �.�. 0 
textoffset 
textOffset�/  3 B�-B L   O VCC J   O UDD EFE o   O P�,�, 0 nonmatchinfo nonMatchInfoF GHG o   P Q�+�+ 0 	matchinfo 	matchInfoH IJI o   Q R�*�* 0 asocmatchend asocMatchEndJ K�)K o   R S�(�( 0 
textoffset 
textOffset�)  �-   � LML l     �'�&�%�'  �&  �%  M NON l     �$�#�"�$  �#  �"  O PQP i  + .RSR I      �!T� �! &0 _matchedgrouplist _matchedGroupListT UVU o      �� 0 
asocstring 
asocStringV WXW o      �� 0 	asocmatch 	asocMatchX YZY o      �� 0 
textoffset 
textOffsetZ [�[ o      �� &0 includenonmatches includeNonMatches�  �   S k     �\\ ]^] r     _`_ J     ��  ` o      �� "0 submatchresults subMatchResults^ aba r    cdc \    efe l   
g��g n   
hih I    
����  0 numberofranges numberOfRanges�  �  i o    �� 0 	asocmatch 	asocMatch�  �  f m   
 �� d o      �� 0 groupindexes groupIndexesb jkj Z    �lm��l ?    non o    �� 0 groupindexes groupIndexeso m    ��  m k    �pp qrq r    sts n   uvu I    �w�� 0 rangeatindex_ rangeAtIndex_w x�
x m    �	�	  �
  �  v o    �� 0 	asocmatch 	asocMatcht o      �� (0 asocfullmatchrange asocFullMatchRanger yzy r    %{|{ n   #}~} I    #���� 0 location  �  �  ~ o    �� (0 asocfullmatchrange asocFullMatchRange| o      �� &0 asocnonmatchstart asocNonMatchStartz � r   & /��� [   & -��� o   & '�� &0 asocnonmatchstart asocNonMatchStart� l  ' ,�� ��� n  ' ,��� I   ( ,�������� 
0 length  ��  ��  � o   ' (���� (0 asocfullmatchrange asocFullMatchRange�   ��  � o      ���� $0 asocfullmatchend asocFullMatchEnd� ��� Y   0 ��������� k   : ��� ��� r   : o��� I      ������� 0 _matchrecords _matchRecords� ��� o   ; <���� 0 
asocstring 
asocString� ��� n  < B��� I   = B������� 0 rangeatindex_ rangeAtIndex_� ���� o   = >���� 0 i  ��  ��  � o   < =���� 0 	asocmatch 	asocMatch� ��� o   B C���� &0 asocnonmatchstart asocNonMatchStart� ��� o   C D���� 0 
textoffset 
textOffset� ��� o   D I���� (0 _unmatchedtexttype _UnmatchedTextType� ���� o   I N���� &0 _matchedgrouptype _MatchedGroupType��  ��  � J      �� ��� o      ���� 0 nonmatchinfo nonMatchInfo� ��� o      ���� 0 	matchinfo 	matchInfo� ��� o      ���� &0 asocnonmatchstart asocNonMatchStart� ���� o      ���� 0 
textoffset 
textOffset��  � ��� Z  p |������� o   p q���� &0 includenonmatches includeNonMatches� r   t x��� o   t u���� 0 nonmatchinfo nonMatchInfo� n      ���  ;   v w� o   u v���� "0 submatchresults subMatchResults��  ��  � ���� r   } ���� o   } ~���� 0 	matchinfo 	matchInfo� n      ���  ;    �� o   ~ ���� "0 submatchresults subMatchResults��  �� 0 i  � m   3 4���� � o   4 5���� 0 groupindexes groupIndexes��  � ���� Z   � �������� o   � ����� &0 includenonmatches includeNonMatches� k   � ��� ��� r   � ���� K   � ��� ������ 0 location  � o   � ����� &0 asocnonmatchstart asocNonMatchStart� ������� 
0 length  � \   � ���� o   � ����� $0 asocfullmatchend asocFullMatchEnd� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  � o      ���� &0 asocnonmatchrange asocNonMatchRange� ���� r   � ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � I   � �������� $0 _matchinforecord _matchInfoRecord� ��� o   � ����� 0 
asocstring 
asocString� ��� o   � ����� &0 asocnonmatchrange asocNonMatchRange� ��� o   � ����� 0 
textoffset 
textOffset� ���� o   � ����� (0 _unmatchedtexttype _UnmatchedTextType��  ��  � n      ���  ;   � �� o   � ����� "0 submatchresults subMatchResults��  ��  ��  ��  �  �  k ���� L   � ��� o   � ����� "0 submatchresults subMatchResults��  Q ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  / 2��� I      ������� 0 _findpattern _findPattern� ��� o      ���� 0 thetext theText� ��� o      ���� 0 patterntext patternText� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � k    �� ��� r     ��� n    ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ���� &0 includenonmatches includeNonMatches� ���� m    �� ���  u n m a t c h e d   t e x t��  ��  � o     ���� 0 _support  � o      ���� &0 includenonmatches includeNonMatches� ��� r    ��� n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ����  0 includematches includeMatches� ���� m       �  m a t c h e d   t e x t��  ��  � o    ���� 0 _support  � o      ����  0 includematches includeMatches�  r    % I    #������ B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter  o    ���� 0 patterntext patternText 	��	 m    

 �  f o r��  ��   o      ���� 0 asocpattern asocPattern  r   & 2 n  & 0 I   + 0������ ,0 asnormalizednsstring asNormalizedNSString �� o   + ,���� 0 thetext theText��  ��   o   & +���� 0 _support   o      ���� 0 
asocstring 
asocString  l  3 6 r   3 6 m   3 4����   o      ���� &0 asocnonmatchstart asocNonMatchStart G A used to calculate NSRanges for non-matching portions of NSString    � �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g  l  7 :  r   7 :!"! m   7 8���� " o      ���� 0 
textoffset 
textOffset B < used to calculate correct AppleScript start and end indexes     �## x   u s e d   t o   c a l c u l a t e   c o r r e c t   A p p l e S c r i p t   s t a r t   a n d   e n d   i n d e x e s $%$ r   ; ?&'& J   ; =����  ' o      ���� 0 
resultlist 
resultList% ()( l  @ @��*+��  * @ : iterate over each non-matched + matched range in NSString   + �,, t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g) -.- r   @ Q/0/ n  @ O121 I   A O��3���� @0 matchesinstring_options_range_ matchesInString_options_range_3 454 o   A B���� 0 
asocstring 
asocString5 676 m   B C����  7 8��8 J   C K99 :;: m   C D����  ; <��< n  D I=>= I   E I�������� 
0 length  ��  ��  > o   D E���� 0 
asocstring 
asocString��  ��  ��  2 o   @ A���� 0 asocpattern asocPattern0 o      ����  0 asocmatcharray asocMatchArray. ?@? Y   R �A��BC��A k   b �DD EFE r   b jGHG l  b hI����I n  b hJKJ I   c h��L����  0 objectatindex_ objectAtIndex_L M��M o   c d���� 0 i  ��  ��  K o   b c����  0 asocmatcharray asocMatchArray��  ��  H o      �� 0 	asocmatch 	asocMatchF NON l  k k�~PQ�~  P � � the first range in match identifies the text matched by the entire pattern, so generate records for full match and its preceding (unmatched) text   Q �RR$   t h e   f i r s t   r a n g e   i n   m a t c h   i d e n t i f i e s   t h e   t e x t   m a t c h e d   b y   t h e   e n t i r e   p a t t e r n ,   s o   g e n e r a t e   r e c o r d s   f o r   f u l l   m a t c h   a n d   i t s   p r e c e d i n g   ( u n m a t c h e d )   t e x tO STS r   k �UVU I      �}W�|�} 0 _matchrecords _matchRecordsW XYX o   l m�{�{ 0 
asocstring 
asocStringY Z[Z n  m s\]\ I   n s�z^�y�z 0 rangeatindex_ rangeAtIndex_^ _�x_ m   n o�w�w  �x  �y  ] o   m n�v�v 0 	asocmatch 	asocMatch[ `a` o   s t�u�u &0 asocnonmatchstart asocNonMatchStarta bcb o   t u�t�t 0 
textoffset 
textOffsetc ded o   u z�s�s (0 _unmatchedtexttype _UnmatchedTextTypee f�rf o   z �q�q $0 _matchedtexttype _MatchedTextType�r  �|  V J      gg hih o      �p�p 0 nonmatchinfo nonMatchInfoi jkj o      �o�o 0 	matchinfo 	matchInfok lml o      �n�n &0 asocnonmatchstart asocNonMatchStartm n�mn o      �l�l 0 
textoffset 
textOffset�m  T opo Z  � �qr�k�jq o   � ��i�i &0 includenonmatches includeNonMatchesr r   � �sts o   � ��h�h 0 nonmatchinfo nonMatchInfot n      uvu  ;   � �v o   � ��g�g 0 
resultlist 
resultList�k  �j  p w�fw Z   � �xy�e�dx o   � ��c�c  0 includematches includeMatchesy k   � �zz {|{ l  � ��b}~�b  } any additional ranges in match identify text matched by group references within regexp pattern, e.g. "([0-9]{4})-([0-9]{2})-([0-9]{2})" will match `YYYY-MM-DD` style date strings, returning the entire text match, plus sub-matches representing year, month and day text   ~ �   a n y   a d d i t i o n a l   r a n g e s   i n   m a t c h   i d e n t i f y   t e x t   m a t c h e d   b y   g r o u p   r e f e r e n c e s   w i t h i n   r e g e x p   p a t t e r n ,   e . g .   " ( [ 0 - 9 ] { 4 } ) - ( [ 0 - 9 ] { 2 } ) - ( [ 0 - 9 ] { 2 } ) "   w i l l   m a t c h   ` Y Y Y Y - M M - D D `   s t y l e   d a t e   s t r i n g s ,   r e t u r n i n g   t h e   e n t i r e   t e x t   m a t c h ,   p l u s   s u b - m a t c h e s   r e p r e s e n t i n g   y e a r ,   m o n t h   a n d   d a y   t e x t| ��a� r   � ���� b   � ���� o   � ��`�` 0 	matchinfo 	matchInfo� K   � ��� �_��^�_ 0 foundgroups foundGroups� I   � ��]��\�] &0 _matchedgrouplist _matchedGroupList� ��� o   � ��[�[ 0 
asocstring 
asocString� ��� o   � ��Z�Z 0 	asocmatch 	asocMatch� ��� n  � ���� o   � ��Y�Y 0 
startindex 
startIndex� o   � ��X�X 0 	matchinfo 	matchInfo� ��W� o   � ��V�V &0 includenonmatches includeNonMatches�W  �\  �^  � n      ���  ;   � �� o   � ��U�U 0 
resultlist 
resultList�a  �e  �d  �f  �� 0 i  B m   U V�T�T  C \   V ]��� l  V [��S�R� n  V [��� I   W [�Q�P�O�Q 	0 count  �P  �O  � o   V W�N�N  0 asocmatcharray asocMatchArray�S  �R  � m   [ \�M�M ��  @ ��� l  � ��L���L  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� Z   ����K�J� o   � ��I�I &0 includenonmatches includeNonMatches� k   ��� ��� r   � ���� c   � ���� l  � ���H�G� n  � ���� I   � ��F��E�F *0 substringfromindex_ substringFromIndex_� ��D� o   � ��C�C &0 asocnonmatchstart asocNonMatchStart�D  �E  � o   � ��B�B 0 
asocstring 
asocString�H  �G  � m   � ��A
�A 
ctxt� o      �@�@ 0 	foundtext 	foundText� ��?� r   ���� K   � ��� �>��
�> 
pcls� o   � ��=�= (0 _unmatchedtexttype _UnmatchedTextType� �<���< 0 
startindex 
startIndex� o   � ��;�; 0 
textoffset 
textOffset� �:���: 0 endindex endIndex� n   � ���� 1   � ��9
�9 
leng� o   � ��8�8 0 thetext theText� �7��6�7 0 	foundtext 	foundText� o   � ��5�5 0 	foundtext 	foundText�6  � n      ���  ;   � � o   � ��4�4 0 
resultlist 
resultList�?  �K  �J  � ��3� L  �� o  �2�2 0 
resultlist 
resultList�3  � ��� l     �1�0�/�1  �0  �/  � ��� l     �.�-�,�.  �-  �,  � ��� l     �+���+  �  -----   � ��� 
 - - - - -� ��� l     �*���*  �   replace pattern   � ���     r e p l a c e   p a t t e r n� ��� l     �)�(�'�)  �(  �'  � ��� i  3 6��� I      �&��%�& "0 _replacepattern _replacePattern� ��� o      �$�$ 0 thetext theText� ��� o      �#�# 0 patterntext patternText� ��"� o      �!�! 0 templatetext templateText�"  �%  � k    K�� ��� r     ��� n    
��� I    
� ���  ,0 asnormalizednsstring asNormalizedNSString� ��� o    �� 0 thetext theText�  �  � o     �� 0 _support  � o      �� 0 
asocstring 
asocString� ��� r    ��� I    ���� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter� ��� o    �� 0 patterntext patternText� ��� m    �� ���  f o r�  �  � o      �� 0 asocpattern asocPattern� ��� Z   K����� =    "��� l    ���� I    ���
� .corecnte****       ****� J    �� ��� o    �� 0 templatetext templateText�  � ���
� 
kocl� m    �
� 
scpt�  �  �  � m     !�� � k   %3�� ��� r   % A��� J   % +�� ��� J   % '�
�
  � � � m   ' (�	�	    � m   ( )�� �  � J        o      �� 0 
resultlist 
resultList  o      �� &0 asocnonmatchstart asocNonMatchStart � o      �� 0 
textoffset 
textOffset�  � 	 r   B S

 n  B Q I   C Q��� @0 matchesinstring_options_range_ matchesInString_options_range_  o   C D� �  0 
asocstring 
asocString  m   D E����   �� J   E M  m   E F����   �� n  F K I   G K�������� 
0 length  ��  ��   o   F G���� 0 
asocstring 
asocString��  ��  �   o   B C���� 0 asocpattern asocPattern o      ����  0 asocmatcharray asocMatchArray	  Y   T ����� k   d �  !  r   d l"#" l  d j$����$ n  d j%&% I   e j��'����  0 objectatindex_ objectAtIndex_' (��( o   e f���� 0 i  ��  ��  & o   d e����  0 asocmatcharray asocMatchArray��  ��  # o      ���� 0 	asocmatch 	asocMatch! )*) r   m �+,+ I      ��-���� 0 _matchrecords _matchRecords- ./. o   n o���� 0 
asocstring 
asocString/ 010 n  o u232 I   p u��4���� 0 rangeatindex_ rangeAtIndex_4 5��5 m   p q����  ��  ��  3 o   o p���� 0 	asocmatch 	asocMatch1 676 o   u v���� &0 asocnonmatchstart asocNonMatchStart7 898 o   v w���� 0 
textoffset 
textOffset9 :;: o   w |���� (0 _unmatchedtexttype _UnmatchedTextType; <��< o   | ����� $0 _matchedtexttype _MatchedTextType��  ��  , J      == >?> o      ���� 0 nonmatchinfo nonMatchInfo? @A@ o      ���� 0 	matchinfo 	matchInfoA BCB o      ���� &0 asocnonmatchstart asocNonMatchStartC D��D o      ���� 0 
textoffset 
textOffset��  * EFE r   � �GHG n  � �IJI o   � ����� 0 	foundtext 	foundTextJ o   � ����� 0 nonmatchinfo nonMatchInfoH n      KLK  ;   � �L o   � ����� 0 
resultlist 
resultListF MNM r   � �OPO I   � ���Q���� &0 _matchedgrouplist _matchedGroupListQ RSR o   � ����� 0 
asocstring 
asocStringS TUT o   � ����� 0 	asocmatch 	asocMatchU VWV n  � �XYX o   � ����� 0 
startindex 
startIndexY o   � ����� 0 	matchinfo 	matchInfoW Z��Z m   � ���
�� boovtrue��  ��  P o      ���� 0 matchedgroups matchedGroupsN [��[ Q   � �\]^\ r   � �_`_ c   � �aba n  � �cdc I   � ���e����  0 replacepattern replacePatterne fgf n  � �hih o   � ����� 0 	foundtext 	foundTexti o   � ����� 0 	matchinfo 	matchInfog j��j o   � ����� 0 matchedgroups matchedGroups��  ��  d o   � ����� 0 templatetext templateTextb m   � ���
�� 
ctxt` n      klk  ;   � �l o   � ����� 0 
resultlist 
resultList] R      ��mn
�� .ascrerr ****      � ****m o      ���� 0 etext eTextn ��op
�� 
errno o      ���� 0 enumber eNumberp ��qr
�� 
erobq o      ���� 0 efrom eFromr ��s��
�� 
errts o      ���� 
0 eto eTo��  ^ R   � ���tu
�� .ascrerr ****      � ****t b   � �vwv m   � �xx �yy � A n   e r r o r   o c c u r r e d   w h e n   c a l l i n g   t h e    r e p l a c e   p a t t e r n    s c r i p t   o b j e c t :  w o   � ����� 0 etext eTextu ��z{
�� 
errnz o   � ����� 0 enumber eNumber{ ��|}
�� 
erob| o   � ����� 0 efrom eFrom} ��~��
�� 
errt~ o   � ����� 
0 eto eTo��  ��  �� 0 i   m   W X����   \   X _� l  X ]������ n  X ]��� I   Y ]�������� 	0 count  ��  ��  � o   X Y����  0 asocmatcharray asocMatchArray��  ��  � m   ] ^���� ��   ��� l  � �������  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� r   � ��� c   � ���� l  � ������� n  � ���� I   � �������� *0 substringfromindex_ substringFromIndex_� ���� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  ��  � o   � ����� 0 
asocstring 
asocString��  ��  � m   � ���
�� 
ctxt� n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList� ��� r  ��� n ��� 1  ��
�� 
txdl� 1  ��
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r  ��� m  �� ���  � n     ��� 1  ��
�� 
txdl� 1  ��
�� 
ascr� ��� r  "��� c  ��� o  ���� 0 
resultlist 
resultList� m  ��
�� 
ctxt� o      ���� 0 
resulttext 
resultText� ��� r  #.��� o  #&���� 0 oldtids oldTIDs� n     ��� 1  )-��
�� 
txdl� 1  &)��
�� 
ascr� ���� L  /3�� o  /2���� 0 
resulttext 
resultText��  �  � L  6K�� c  6J��� l 6F������ n 6F��� I  7F������� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� ��� l 
78������ o  78���� 0 
asocstring 
asocString��  ��  � ��� m  89����  � ��� J  9A�� ��� m  9:����  � ���� n :?��� I  ;?�������� 
0 length  ��  ��  � o  :;���� 0 
asocstring 
asocString��  � ���� o  AB���� 0 templatetext templateText��  ��  � o  67���� 0 asocpattern asocPattern��  ��  � m  FI��
�� 
ctxt�  � ��� l     ����~��  �  �~  � ��� l     �}�|�{�}  �|  �{  � ��� l     �z���z  �  -----   � ��� 
 - - - - -� ��� l     �y���y  �  
 find text   � ���    f i n d   t e x t� ��� l     �x�w�v�x  �w  �v  � ��� i  7 :��� I      �u��t�u 0 	_findtext 	_findText� ��� o      �s�s 0 thetext theText� ��� o      �r�r 0 fortext forText� ��� o      �q�q &0 includenonmatches includeNonMatches� ��p� o      �o�o  0 includematches includeMatches�p  �t  � k    	�� ��� r     ��� J     �n�n  � o      �m�m 0 
resultlist 
resultList� ��� r    
��� n   ��� 1    �l
�l 
txdl� 1    �k
�k 
ascr� o      �j�j 0 oldtids oldTIDs� ��� r    ��� o    �i�i 0 fortext forText� n     ��� 1    �h
�h 
txdl� 1    �g
�g 
ascr� ��� r    ��� m    �f�f � o      �e�e 0 
startindex 
startIndex� ��� r    ��� n    ��� 1    �d
�d 
leng� n    ��� 4    �c 
�c 
citm  m    �b�b � o    �a�a 0 thetext theText� o      �`�` 0 endindex endIndex�  Z    Q�_�^ o    �]�] &0 includenonmatches includeNonMatches k   " M  Z   " ;	�\
 B   " % o   " #�[�[ 0 
startindex 
startIndex o   # $�Z�Z 0 endindex endIndex	 r   ( 5 n   ( 3 7  ) 3�Y
�Y 
ctxt o   - /�X�X 0 
startindex 
startIndex o   0 2�W�W 0 endindex endIndex o   ( )�V�V 0 thetext theText o      �U�U 0 	foundtext 	foundText�\  
 r   8 ; m   8 9 �   o      �T�T 0 	foundtext 	foundText �S r   < M K   < J �R
�R 
pcls o   = B�Q�Q (0 _unmatchedtexttype _UnmatchedTextType �P�P 0 
startindex 
startIndex o   C D�O�O 0 
startindex 
startIndex �N �N 0 endindex endIndex o   E F�M�M 0 endindex endIndex  �L!�K�L 0 	foundtext 	foundText! o   G H�J�J 0 	foundtext 	foundText�K   n      "#"  ;   K L# o   J K�I�I 0 
resultlist 
resultList�S  �_  �^   $%$ Y   R &�H'(�G& k   b �)) *+* r   b g,-, [   b e./. o   b c�F�F 0 endindex endIndex/ m   c d�E�E - o      �D�D 0 
startindex 
startIndex+ 010 r   h }232 \   h {454 l  h k6�C�B6 n   h k787 1   i k�A
�A 
leng8 o   h i�@�@ 0 thetext theText�C  �B  5 l  k z9�?�>9 n   k z:;: 1   x z�=
�= 
leng; n   k x<=< 7  l x�<>?
�< 
ctxt> l  p s@�;�:@ 4   p s�9A
�9 
citmA o   q r�8�8 0 i  �;  �:  ? l  t wB�7�6B 4   t w�5C
�5 
citmC m   u v�4�4���7  �6  = o   k l�3�3 0 thetext theText�?  �>  3 o      �2�2 0 endindex endIndex1 DED Z   ~ �FG�1�0F o   ~ �/�/  0 includematches includeMatchesG k   � �HH IJI Z   � �KL�.MK B   � �NON o   � ��-�- 0 
startindex 
startIndexO o   � ��,�, 0 endindex endIndexL r   � �PQP n   � �RSR 7  � ��+TU
�+ 
ctxtT o   � ��*�* 0 
startindex 
startIndexU o   � ��)�) 0 endindex endIndexS o   � ��(�( 0 thetext theTextQ o      �'�' 0 	foundtext 	foundText�.  M r   � �VWV m   � �XX �YY  W o      �&�& 0 	foundtext 	foundTextJ Z�%Z r   � �[\[ K   � �]] �$^_
�$ 
pcls^ o   � ��#�# $0 _matchedtexttype _MatchedTextType_ �"`a�" 0 
startindex 
startIndex` o   � ��!�! 0 
startindex 
startIndexa � bc�  0 endindex endIndexb o   � ��� 0 endindex endIndexc �de� 0 	foundtext 	foundTextd o   � ��� 0 	foundtext 	foundTexte �f�� 0 foundgroups foundGroupsf J   � ���  �  \ n      ghg  ;   � �h o   � ��� 0 
resultlist 
resultList�%  �1  �0  E iji r   � �klk [   � �mnm o   � ��� 0 endindex endIndexn m   � ��� l o      �� 0 
startindex 
startIndexj opo r   � �qrq \   � �sts [   � �uvu o   � ��� 0 
startindex 
startIndexv l  � �w��w n   � �xyx 1   � ��
� 
lengy n   � �z{z 4   � ��|
� 
citm| o   � ��� 0 i  { o   � ��� 0 thetext theText�  �  t m   � ��� r o      �� 0 endindex endIndexp }�} Z   � �~��
~ o   � ��	�	 &0 includenonmatches includeNonMatches k   � ��� ��� Z   � ������ B   � ���� o   � ��� 0 
startindex 
startIndex� o   � ��� 0 endindex endIndex� r   � ���� n   � ���� 7  � ����
� 
ctxt� o   � ��� 0 
startindex 
startIndex� o   � ��� 0 endindex endIndex� o   � ��� 0 thetext theText� o      �� 0 	foundtext 	foundText�  � r   � ���� m   � ��� ���  � o      � �  0 	foundtext 	foundText� ���� r   � ���� K   � ��� ����
�� 
pcls� o   � ����� (0 _unmatchedtexttype _UnmatchedTextType� ������ 0 
startindex 
startIndex� o   � ����� 0 
startindex 
startIndex� ������ 0 endindex endIndex� o   � ����� 0 endindex endIndex� ������� 0 	foundtext 	foundText� o   � ����� 0 	foundtext 	foundText��  � n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  �  �
  �  �H 0 i  ' m   U V���� ( I  V ]�����
�� .corecnte****       ****� n   V Y��� 2  W Y��
�� 
citm� o   V W���� 0 thetext theText��  �G  % ��� r  ��� o  ���� 0 oldtids oldTIDs� n     ��� 1  ��
�� 
txdl� 1  ��
�� 
ascr� ���� L  	�� o  ���� 0 
resultlist 
resultList��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ������  �   replace text   � ���    r e p l a c e   t e x t� ��� l     ��������  ��  ��  � ��� i  ; >��� I      ������� 0 _replacetext _replaceText� ��� o      ���� 0 thetext theText� ��� o      ���� 0 fortext forText� ���� o      ���� 0 newtext newText��  ��  � k    '�� ��� r     ��� n    ��� 1    ��
�� 
txdl� 1     ��
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r    ��� o    ���� 0 fortext forText� n     ��� 1    
��
�� 
txdl� 1    ��
�� 
ascr� ��� Z   ������ >    ��� l   ������ I   ����
�� .corecnte****       ****� J    �� ���� o    ���� 0 newtext newText��  � �����
�� 
kocl� m    ��
�� 
scpt��  ��  ��  � m    ����  � k    ��� ��� r    ;��� J    %�� ��� J    ����  � ��� m    ���� � ���� n    #��� 1   ! #��
�� 
leng� n    !��� 4    !���
�� 
citm� m     ���� � o    ���� 0 thetext theText��  � J      �� ��� o      ���� 0 
resultlist 
resultList� ��� o      ���� 0 
startindex 
startIndex� ���� o      ���� 0 endindex endIndex��  � ��� Z  < T������� B   < ?��� o   < =���� 0 
startindex 
startIndex� o   = >���� 0 endindex endIndex� r   B P��� n   B M��� 7  C M����
�� 
ctxt� o   G I���� 0 
startindex 
startIndex� o   J L���� 0 endindex endIndex� o   B C���� 0 thetext theText� n          ;   N O o   M N���� 0 
resultlist 
resultList��  ��  �  Y   U ����� k   e � 	 r   e j

 [   e h o   e f���� 0 endindex endIndex m   f g����  o      ���� 0 
startindex 
startIndex	  r   k � \   k ~ l  k n���� n   k n 1   l n��
�� 
leng o   k l���� 0 thetext theText��  ��   l  n }���� n   n } 1   { }��
�� 
leng n   n { 7  o {��
�� 
ctxt l  s v���� 4   s v��
�� 
citm o   t u���� 0 i  ��  ��   l  w z ����  4   w z��!
�� 
citm! m   x y��������  ��   o   n o���� 0 thetext theText��  ��   o      ���� 0 endindex endIndex "#" Z   � �$%��&$ B   � �'(' o   � ����� 0 
startindex 
startIndex( o   � ����� 0 endindex endIndex% r   � �)*) n   � �+,+ 7  � ���-.
�� 
ctxt- o   � ����� 0 
startindex 
startIndex. o   � ����� 0 endindex endIndex, o   � ����� 0 thetext theText* o      ���� 0 	foundtext 	foundText��  & r   � �/0/ m   � �11 �22  0 o      ���� 0 	foundtext 	foundText# 343 Q   � �5675 r   � �898 c   � �:;: n  � �<=< I   � ���>���� 0 replacetext replaceText> ?��? o   � ����� 0 	foundtext 	foundText��  ��  = o   � ����� 0 newtext newText; m   � ���
�� 
ctxt9 n      @A@  ;   � �A o   � ����� 0 
resultlist 
resultList6 R      ��BC
�� .ascrerr ****      � ****B o      ���� 0 etext eTextC ��DE
�� 
errnD o      ���� 0 enumber eNumberE ��FG
�� 
erobF o      ���� 0 efrom eFromG ��H��
�� 
errtH o      ���� 
0 eto eTo��  7 R   � ���IJ
�� .ascrerr ****      � ****I b   � �KLK m   � �MM �NN � A n   e r r o r   o c c u r r e d   w h e n   c a l l i n g   t h e    r e p l a c e   t e x t    s c r i p t   o b j e c t :  L o   � ����� 0 etext eTextJ ��OP
�� 
errnO o   � ����� 0 enumber eNumberP ��QR
�� 
erobQ o   � ����� 0 efrom eFromR �S�~
� 
errtS o   � ��}�} 
0 eto eTo�~  4 TUT r   � �VWV [   � �XYX o   � ��|�| 0 endindex endIndexY m   � ��{�{ W o      �z�z 0 
startindex 
startIndexU Z[Z r   � �\]\ \   � �^_^ [   � �`a` o   � ��y�y 0 
startindex 
startIndexa l  � �b�x�wb n   � �cdc 1   � ��v
�v 
lengd n   � �efe 4   � ��ug
�u 
citmg o   � ��t�t 0 i  f o   � ��s�s 0 thetext theText�x  �w  _ m   � ��r�r ] o      �q�q 0 endindex endIndex[ h�ph Z  � �ij�o�ni B   � �klk o   � ��m�m 0 
startindex 
startIndexl o   � ��l�l 0 endindex endIndexj r   � �mnm n   � �opo 7  � ��kqr
�k 
ctxtq o   � ��j�j 0 
startindex 
startIndexr o   � ��i�i 0 endindex endIndexp o   � ��h�h 0 thetext theTextn n      sts  ;   � �t o   � ��g�g 0 
resultlist 
resultList�o  �n  �p  �� 0 i   m   X Y�f�f  I  Y `�eu�d
�e .corecnte****       ****u n   Y \vwv 2  Z \�c
�c 
citmw o   Y Z�b�b 0 thetext theText�d  ��   x�ax r   � �yzy m   � �{{ �||  z n     }~} 1   � ��`
�` 
txdl~ 1   � ��_
�_ 
ascr�a  ��  � l  ��� k   ��� ��� l  � ��^���^  �   replace with text   � ��� $   r e p l a c e   w i t h   t e x t� ��� r   ���� n  �
��� I  
�]��\�] "0 astextparameter asTextParameter� ��� o  �[�[ 0 newtext newText� ��Z� m  �� ���  r e p l a c i n g   w i t h�Z  �\  � o   ��Y�Y 0 _support  � o      �X�X 0 newtext newText� ��� l ���� r  ��� n ��� 2 �W
�W 
citm� o  �V�V 0 thetext theText� o      �U�U 0 
resultlist 
resultList� J D note: TID-based matching uses current considering/ignoring settings   � ��� �   n o t e :   T I D - b a s e d   m a t c h i n g   u s e s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s� ��T� r  ��� o  �S�S 0 newtext newText� n     ��� 1  �R
�R 
txdl� 1  �Q
�Q 
ascr�T  � * $ replace with callback-supplied text   � ��� H   r e p l a c e   w i t h   c a l l b a c k - s u p p l i e d   t e x t� ��� r  ��� c  ��� o  �P�P 0 
resultlist 
resultList� m  �O
�O 
ctxt� o      �N�N 0 
resulttext 
resultText� ��� r  $��� o   �M�M 0 oldtids oldTIDs� n     ��� 1  !#�L
�L 
txdl� 1   !�K
�K 
ascr� ��J� L  %'�� o  %&�I�I 0 
resulttext 
resultText�J  � ��� l     �H�G�F�H  �G  �F  � ��� l     �E�D�C�E  �D  �C  � ��� l     �B���B  �  -----   � ��� 
 - - - - -� ��� l     �A�@�?�A  �@  �?  � ��� i  ? B��� I     �>��
�> .Txt:Srchnull���     ctxt� o      �=�= 0 thetext theText� �<��
�< 
For_� o      �;�; 0 fortext forText� �:��
�: 
Usin� |�9�8��7��9  �8  � o      �6�6 0 matchformat matchFormat�7  � l 
    ��5�4� l     ��3�2� m      �1
�1 SerECmpI�3  �2  �5  �4  � �0��
�0 
Repl� |�/�.��-��/  �.  � o      �,�, 0 newtext newText�-  � l     ��+�*� m      �)
�) 
msng�+  �*  � �(��'
�( 
Retu� |�&�%��$��&  �%  � o      �#�# 0 resultformat resultFormat�$  � l     ��"�!� m      � 
�  RetEMatT�"  �!  �'  � Q    O���� k   9�� ��� r    ��� n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    	�� 0 thetext theText� ��� m   	 
�� ���  �  �  � o    �� 0 _support  � o      �� 0 thetext theText� ��� r    ��� n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    �� 0 fortext forText� ��� m    �� ���  f o r�  �  � o    �� 0 _support  � o      �� 0 fortext forText� ��� Z   3����� =    $��� n   "��� 1     "�
� 
leng� o     �� 0 fortext forText� m   " #��  � R   ' /���
� .ascrerr ****      � ****� m   - .�� ��� t I n v a l i d    f o r    p a r a m e t e r   ( e x p e c t e d   o n e   o r   m o r e   c h a r a c t e r s ) .� ���
� 
errn� m   ) *���Y� ���

� 
erob� o   + ,�	�	 0 fortext forText�
  �  �  � ��� Z   49 �  =  4 7 o   4 5�� 0 newtext newText m   5 6�
� 
msng l  :� k   :� 	
	 Z   : e�� =   : ? n  : = 1   ; =�
� 
leng o   : ;�� 0 thetext theText m   = >� �    Z   B a�� =  B E o   B C���� 0 resultformat resultFormat m   C D��
�� RetEMatT L   H K J   H J����  ��   L   N a J   N ` �� K   N ^ ��
�� 
pcls o   O T���� (0 _unmatchedtexttype _UnmatchedTextType ���� 0 
startindex 
startIndex m   U V����  �� �� 0 endindex endIndex m   W X����    ��!���� 0 	foundtext 	foundText! m   Y Z"" �##  ��  ��  �  �  
 $%$ Z   f �&'()& =  f i*+* o   f g���� 0 resultformat resultFormat+ m   g h��
�� RetEMatT' r   l �,-, J   l p.. /0/ m   l m��
�� boovfals0 1��1 m   m n��
�� boovtrue��  - J      22 343 o      ���� &0 includenonmatches includeNonMatches4 5��5 o      ����  0 includematches includeMatches��  ( 676 =  � �898 o   � ����� 0 resultformat resultFormat9 m   � ���
�� RetEUmaT7 :;: r   � �<=< J   � �>> ?@? m   � ���
�� boovtrue@ A��A m   � ���
�� boovfals��  = J      BB CDC o      ���� &0 includenonmatches includeNonMatchesD E��E o      ����  0 includematches includeMatches��  ; FGF =  � �HIH o   � ����� 0 resultformat resultFormatI m   � ���
�� RetEAllTG J��J r   � �KLK J   � �MM NON m   � ���
�� boovtrueO P��P m   � ���
�� boovtrue��  L J      QQ RSR o      ���� &0 includenonmatches includeNonMatchesS T��T o      ����  0 includematches includeMatches��  ��  ) n  � �UVU I   � ���W���� >0 throwinvalidconstantparameter throwInvalidConstantParameterW XYX o   � ����� 0 resultformat resultFormatY Z��Z m   � �[[ �\\  r e t u r n i n g��  ��  V o   � ����� 0 _support  % ]��] Z   ��^_`a^ =  � �bcb o   � ����� 0 matchformat matchFormatc m   � ���
�� SerECmpI_ P   � �defd L   � �gg I   � ���h���� 0 	_findtext 	_findTexth iji o   � ����� 0 thetext theTextj klk o   � ����� 0 fortext forTextl mnm o   � ����� &0 includenonmatches includeNonMatchesn o��o o   � �����  0 includematches includeMatches��  ��  e ��p
�� consdiacp ��q
�� conshyphq ��r
�� conspuncr ��s
�� conswhits ����
�� consnume��  f ����
�� conscase��  ` tut =  � �vwv o   � ����� 0 matchformat matchFormatw m   � ���
�� SerECmpPu xyx L   �	zz I   ���{���� 0 _findpattern _findPattern{ |}| o   ���� 0 thetext theText} ~~ o  ���� 0 fortext forText ��� o  ���� &0 includenonmatches includeNonMatches� ���� o  ����  0 includematches includeMatches��  ��  y ��� = ��� o  ���� 0 matchformat matchFormat� m  ��
�� SerECmpC� ��� P  &����� L  %�� I  $������� 0 	_findtext 	_findText� ��� o  ���� 0 thetext theText� ��� o  ���� 0 fortext forText� ��� o  ���� &0 includenonmatches includeNonMatches� ���� o   ����  0 includematches includeMatches��  ��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  ��  � ��� = ).��� o  )*���� 0 matchformat matchFormat� m  *-��
�� SerECmpE� ��� P  1E���� L  :D�� I  :C������� 0 	_findtext 	_findText� ��� o  ;<���� 0 thetext theText� ��� o  <=���� 0 fortext forText� ��� o  =>���� &0 includenonmatches includeNonMatches� ���� o  >?����  0 includematches includeMatches��  ��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  � ��� = HM��� o  HI���� 0 matchformat matchFormat� m  IL��
�� SerECmpD� ���� k  Pq�� ��� l Pf���� Z Pf������� = PU��� o  PQ���� 0 fortext forText� m  QT�� ���  � R  Xb����
�� .ascrerr ****      � ****� m  ^a�� ��� � I n v a l i d    f o r    p a r a m e t e r   ( c o n t a i n s   o n l y   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r a t i o n s ) .� ����
�� 
errn� m  Z[�����Y� �����
�� 
erob� o  \]���� 0 fortext forText��  ��  ��  ��� checks if all characters in forText are ignored by current considering/ignoring settings (the alternative would be to return each character as a non-match separated by a zero-length match, but that's probably not what the user intended); note that unlike `aString's length = 0`, which is what library code normally uses to check for empty text, on this occasion we do want to take into account the current considering/ignoring settings so deliberately use `forText is ""` here. For example, when ignoring punctuation, searching for the TID `"!?"` is no different to searching for `""`, because all of its characters are being ignored when comparing the text being searched against the text being searched for. Thus, a simple `forText is ""` test can be used to check in advance if the text contains any matchable characters under the current considering/ignoring settings, and report a meaningful error if not.   � ���   c h e c k s   i f   a l l   c h a r a c t e r s   i n   f o r T e x t   a r e   i g n o r e d   b y   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   ( t h e   a l t e r n a t i v e   w o u l d   b e   t o   r e t u r n   e a c h   c h a r a c t e r   a s   a   n o n - m a t c h   s e p a r a t e d   b y   a   z e r o - l e n g t h   m a t c h ,   b u t   t h a t ' s   p r o b a b l y   n o t   w h a t   t h e   u s e r   i n t e n d e d ) ;   n o t e   t h a t   u n l i k e   ` a S t r i n g ' s   l e n g t h   =   0 ` ,   w h i c h   i s   w h a t   l i b r a r y   c o d e   n o r m a l l y   u s e s   t o   c h e c k   f o r   e m p t y   t e x t ,   o n   t h i s   o c c a s i o n   w e   d o   w a n t   t o   t a k e   i n t o   a c c o u n t   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   s o   d e l i b e r a t e l y   u s e   ` f o r T e x t   i s   " " `   h e r e .   F o r   e x a m p l e ,   w h e n   i g n o r i n g   p u n c t u a t i o n ,   s e a r c h i n g   f o r   t h e   T I D   ` " ! ? " `   i s   n o   d i f f e r e n t   t o   s e a r c h i n g   f o r   ` " " ` ,   b e c a u s e   a l l   o f   i t s   c h a r a c t e r s   a r e   b e i n g   i g n o r e d   w h e n   c o m p a r i n g   t h e   t e x t   b e i n g   s e a r c h e d   a g a i n s t   t h e   t e x t   b e i n g   s e a r c h e d   f o r .   T h u s ,   a   s i m p l e   ` f o r T e x t   i s   " " `   t e s t   c a n   b e   u s e d   t o   c h e c k   i n   a d v a n c e   i f   t h e   t e x t   c o n t a i n s   a n y   m a t c h a b l e   c h a r a c t e r s   u n d e r   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   a n d   r e p o r t   a   m e a n i n g f u l   e r r o r   i f   n o t .� ���� L  gq�� I  gp������� 0 	_findtext 	_findText� ��� o  hi���� 0 thetext theText� ��� o  ij���� 0 fortext forText� ��� o  jk���� &0 includenonmatches includeNonMatches� ���� o  kl����  0 includematches includeMatches��  ��  ��  ��  a n t���� I  y�������� >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o  yz���� 0 matchformat matchFormat� ���� m  z}�� ��� 
 u s i n g��  ��  � o  ty�� 0 _support  ��     find matches    ���    f i n d   m a t c h e s�   l �9���� k  �9�� ��� Z �����~�}� =  ����� n ����� 1  ���|
�| 
leng� o  ���{�{ 0 thetext theText� m  ���z�z  � L  ���� m  ���� ���  �~  �}  � ��y� Z  �9����� = ����� o  ���x�x 0 matchformat matchFormat� m  ���w
�w SerECmpI� P  ������ L  ���� I  ���v��u�v 0 _replacetext _replaceText� ��� o  ���t�t 0 thetext theText� ��� o  ���s�s 0 fortext forText� ��r� o  ���q�q 0 newtext newText�r  �u  � �p�
�p consdiac� �o�
�o conshyph� �n�
�n conspunc� �m�
�m conswhit� �l�k
�l consnume�k  � �j�i
�j conscase�i  � � � = �� o  ���h�h 0 matchformat matchFormat m  ���g
�g SerECmpP   L  �� I  ���f�e�f "0 _replacepattern _replacePattern  o  ���d�d 0 thetext theText 	
	 o  ���c�c 0 fortext forText
 �b o  ���a�a 0 newtext newText�b  �e    = �� o  ���`�` 0 matchformat matchFormat m  ���_
�_ SerECmpE  P  �� L  �� I  ���^�]�^ 0 _replacetext _replaceText  o  ���\�\ 0 thetext theText  o  ���[�[ 0 fortext forText �Z o  ���Y�Y 0 newtext newText�Z  �]   �X
�X conscase �W
�W consdiac �V
�V conshyph �U
�U conspunc �T�S
�T conswhit�S   �R�Q
�R consnume�Q    !  = ��"#" o  ���P�P 0 matchformat matchFormat# m  ���O
�O SerECmpC! $%$ P  ��&'�N& L  ��(( I  ���M)�L�M 0 _replacetext _replaceText) *+* o  ���K�K 0 thetext theText+ ,-, o  ���J�J 0 fortext forText- .�I. o  ���H�H 0 newtext newText�I  �L  ' �G/
�G conscase/ �F0
�F consdiac0 �E1
�E conshyph1 �D2
�D conspunc2 �C3
�C conswhit3 �B�A
�B consnume�A  �N  % 454 = 676 o  �@�@ 0 matchformat matchFormat7 m  �?
�? SerECmpD5 8�>8 k  	)99 :;: Z 	<=�=�<< = 	>?> o  	
�;�; 0 fortext forText? m  
@@ �AA  = R  �:BC
�: .ascrerr ****      � ****B m  DD �EE � I n v a l i d    f o r    p a r a m e t e r   ( c o n t a i n s   o n l y   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r a t i o n s ) .C �9FG
�9 
errnF m  �8�8�YG �7H�6
�7 
erobH o  �5�5 0 fortext forText�6  �=  �<  ; I�4I L   )JJ I   (�3K�2�3 0 _replacetext _replaceTextK LML o  !"�1�1 0 thetext theTextM NON o  "#�0�0 0 fortext forTextO P�/P o  #$�.�. 0 newtext newText�/  �2  �4  �>  � n ,9QRQ I  19�-S�,�- >0 throwinvalidconstantparameter throwInvalidConstantParameterS TUT o  12�+�+ 0 matchformat matchFormatU V�*V m  25WW �XX 
 u s i n g�*  �,  R o  ,1�)�) 0 _support  �y  �   replace matches   � �YY     r e p l a c e   m a t c h e s�  � R      �(Z[
�( .ascrerr ****      � ****Z o      �'�' 0 etext eText[ �&\]
�& 
errn\ o      �%�% 0 enumber eNumber] �$^_
�$ 
erob^ o      �#�# 0 efrom eFrom_ �"`�!
�" 
errt` o      � �  
0 eto eTo�!  � I  AO�a�� 
0 _error  a bcb m  BEdd �ee  s e a r c h   t e x tc fgf o  EF�� 0 etext eTextg hih o  FG�� 0 enumber eNumberi jkj o  GH�� 0 efrom eFromk l�l o  HI�� 
0 eto eTo�  �  � mnm l     ����  �  �  n opo l     ����  �  �  p qrq i  C Fsts I     �u�
� .Txt:EPatnull���     ctxtu o      �� 0 thetext theText�  t Q     *vwxv L    yy c    z{z l   |��| n   }~} I    ��� 40 escapedpatternforstring_ escapedPatternForString_ ��� l   ��
�	� n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    �� 0 thetext theText� ��� m    �� ���  �  �  � o    �� 0 _support  �
  �	  �  �  ~ n   ��� o    �� *0 nsregularexpression NSRegularExpression� m    �
� misccura�  �  { m    �
� 
ctxtw R      � ��
�  .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  x I     *������� 
0 _error  � ��� m   ! "�� ���  e s c a p e   p a t t e r n� ��� o   " #���� 0 etext eText� ��� o   # $���� 0 enumber eNumber� ��� o   $ %���� 0 efrom eFrom� ���� o   % &���� 
0 eto eTo��  ��  r ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  G J��� I     �����
�� .Txt:ETemnull���     ctxt� o      ���� 0 thetext theText��  � Q     *���� L    �� c    ��� l   ������ n   ��� I    ������� 60 escapedtemplateforstring_ escapedTemplateForString_� ���� l   ������ n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _support  ��  ��  ��  ��  � n   ��� o    ���� *0 nsregularexpression NSRegularExpression� m    ��
�� misccura��  ��  � m    ��
�� 
ctxt� R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I     *������� 
0 _error  � ��� m   ! "�� ���  e s c a p e   t e m p l a t e� ��� o   " #���� 0 etext eText� ��� o   # $���� 0 enumber eNumber� ��� o   $ %���� 0 efrom eFrom� ���� o   % &���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   Conversion Suite   � ��� "   C o n v e r s i o n   S u i t e� ��� l     ��������  ��  ��  � ��� i  K N��� I     ����
�� .Txt:UppTnull���     ctxt� o      ���� 0 thetext theText� �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � m      ��
�� 
msng��  � Q     P���� k    >�� ��� r    ��� n   ��� I    ������� 0 
asnsstring 
asNSString� ���� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _support  ��  ��  � o    ���� 0 _support  � o      ���� 0 
asocstring 
asocString� ���� Z    >� ��� =    o    ���� 0 
localecode 
localeCode m    ��
�� 
msng  L     ( c     ' l    %���� n    %	 I   ! %�������� "0 uppercasestring uppercaseString��  ��  	 o     !���� 0 
asocstring 
asocString��  ��   m   % &��
�� 
ctxt��   L   + >

 c   + = l  + ;���� n  + ; I   , ;������ 80 uppercasestringwithlocale_ uppercaseStringWithLocale_ �� l  , 7���� n  , 7 I   1 7������ *0 asnslocaleparameter asNSLocaleParameter  o   1 2���� 0 
localecode 
localeCode �� m   2 3 �  f o r   l o c a l e��  ��   o   , 1���� 0 _support  ��  ��  ��  ��   o   + ,���� 0 
asocstring 
asocString��  ��   m   ; <��
�� 
ctxt��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber �� 
�� 
erob o      ���� 0 efrom eFrom  ��!��
�� 
errt! o      ���� 
0 eto eTo��  � I   F P��"���� 
0 _error  " #$# m   G H%% �&&  u p p e r c a s e   t e x t$ '(' o   H I���� 0 etext eText( )*) o   I J���� 0 enumber eNumber* +,+ o   J K���� 0 efrom eFrom, -��- o   K L���� 
0 eto eTo��  ��  � ./. l     �������  ��  �  / 010 l     �~�}�|�~  �}  �|  1 232 i  O R454 I     �{67
�{ .Txt:CapTnull���     ctxt6 o      �z�z 0 thetext theText7 �y8�x
�y 
Loca8 |�w�v9�u:�w  �v  9 o      �t�t 0 
localecode 
localeCode�u  : m      �s
�s 
msng�x  5 Q     P;<=; k    >>> ?@? r    ABA n   CDC I    �rE�q�r 0 
asnsstring 
asNSStringE F�pF n   GHG I    �oI�n�o "0 astextparameter asTextParameterI JKJ o    �m�m 0 thetext theTextK L�lL m    MM �NN  �l  �n  H o    �k�k 0 _support  �p  �q  D o    �j�j 0 _support  B o      �i�i 0 
asocstring 
asocString@ O�hO Z    >PQ�gRP =   STS o    �f�f 0 
localecode 
localeCodeT m    �e
�e 
msngQ L     (UU c     'VWV l    %X�d�cX n    %YZY I   ! %�b�a�`�b &0 capitalizedstring capitalizedString�a  �`  Z o     !�_�_ 0 
asocstring 
asocString�d  �c  W m   % &�^
�^ 
ctxt�g  R L   + >[[ c   + =\]\ l  + ;^�]�\^ n  + ;_`_ I   , ;�[a�Z�[ <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_a b�Yb l  , 7c�X�Wc n  , 7ded I   1 7�Vf�U�V *0 asnslocaleparameter asNSLocaleParameterf ghg o   1 2�T�T 0 
localecode 
localeCodeh i�Si m   2 3jj �kk  f o r   l o c a l e�S  �U  e o   , 1�R�R 0 _support  �X  �W  �Y  �Z  ` o   + ,�Q�Q 0 
asocstring 
asocString�]  �\  ] m   ; <�P
�P 
ctxt�h  < R      �Olm
�O .ascrerr ****      � ****l o      �N�N 0 etext eTextm �Mno
�M 
errnn o      �L�L 0 enumber eNumbero �Kpq
�K 
erobp o      �J�J 0 efrom eFromq �Ir�H
�I 
errtr o      �G�G 
0 eto eTo�H  = I   F P�Fs�E�F 
0 _error  s tut m   G Hvv �ww  c a p i t a l i z e   t e x tu xyx o   H I�D�D 0 etext eTexty z{z o   I J�C�C 0 enumber eNumber{ |}| o   J K�B�B 0 efrom eFrom} ~�A~ o   K L�@�@ 
0 eto eTo�A  �E  3 � l     �?�>�=�?  �>  �=  � ��� l     �<�;�:�<  �;  �:  � ��� i  S V��� I     �9��
�9 .Txt:LowTnull���     ctxt� o      �8�8 0 thetext theText� �7��6
�7 
Loca� |�5�4��3��5  �4  � o      �2�2 0 
localecode 
localeCode�3  � m      �1
�1 
msng�6  � Q     P���� k    >�� ��� r    ��� n   ��� I    �0��/�0 0 
asnsstring 
asNSString� ��.� n   ��� I    �-��,�- "0 astextparameter asTextParameter� ��� o    �+�+ 0 thetext theText� ��*� m    �� ���  �*  �,  � o    �)�) 0 _support  �.  �/  � o    �(�( 0 _support  � o      �'�' 0 
asocstring 
asocString� ��&� Z    >���%�� =   ��� o    �$�$ 0 
localecode 
localeCode� m    �#
�# 
msng� L     (�� c     '��� l    %��"�!� n    %��� I   ! %� ���  "0 lowercasestring lowercaseString�  �  � o     !�� 0 
asocstring 
asocString�"  �!  � m   % &�
� 
ctxt�%  � L   + >�� c   + =��� l  + ;���� n  + ;��� I   , ;���� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_� ��� l  , 7���� n  , 7��� I   1 7���� *0 asnslocaleparameter asNSLocaleParameter� ��� o   1 2�� 0 
localecode 
localeCode� ��� m   2 3�� ���  f o r   l o c a l e�  �  � o   , 1�� 0 _support  �  �  �  �  � o   + ,�� 0 
asocstring 
asocString�  �  � m   ; <�
� 
ctxt�&  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �
�
 0 enumber eNumber� �	��
�	 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I   F P���� 
0 _error  � ��� m   G H�� ���  l o w e r c a s e   t e x t� ��� o   H I�� 0 etext eText� ��� o   I J�� 0 enumber eNumber� ��� o   J K� �  0 efrom eFrom� ���� o   K L���� 
0 eto eTo��  �  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  W Z��� I     ����
�� .Txt:FTxtnull���     ctxt� o      ���� 0 templatetext templateText� �����
�� 
Usin� o      ���� 0 	thevalues 	theValues��  � k    [�� ��� l     ������  � � � note: templateText uses same `$n` (where n=1-9) notation as `search text`'s replacement templates, with `\$` to escape as necessary ($ not followed by a digit will appear as-is)   � ���d   n o t e :   t e m p l a t e T e x t   u s e s   s a m e   ` $ n `   ( w h e r e   n = 1 - 9 )   n o t a t i o n   a s   ` s e a r c h   t e x t ` ' s   r e p l a c e m e n t   t e m p l a t e s ,   w i t h   ` \ $ `   t o   e s c a p e   a s   n e c e s s a r y   ( $   n o t   f o l l o w e d   b y   a   d i g i t   w i l l   a p p e a r   a s - i s )� ���� Q    [���� P   A���� k   @�� ��� r    ��� n   ��� I    ������� 0 aslist asList� ���� o    ���� 0 	thevalues 	theValues��  ��  � o    ���� 0 _support  � o      ���� 0 	thevalues 	theValues� ��� l   !���� r    !��� n   ��� I    ������� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_� ��� m    �� ���  \ \ . | \ $ [ 1 - 9 ]� �	 � m    ����  	  	��	 l   	����	 m    ��
�� 
msng��  ��  ��  ��  � n   			 o    ���� *0 nsregularexpression NSRegularExpression	 m    ��
�� misccura� o      ���� 0 asocpattern asocPattern� E ? match any backslash escaped character or a $ followed by digit   � �		 ~   m a t c h   a n y   b a c k s l a s h   e s c a p e d   c h a r a c t e r   o r   a   $   f o l l o w e d   b y   d i g i t� 			 r   " .				 n  " ,	
		
 I   ' ,��	���� 0 
asnsstring 
asNSString	 	��	 o   ' (���� 0 templatetext templateText��  ��  	 o   " '���� 0 _support  		 o      ���� 0 
asocstring 
asocString	 			 r   / @			 l  / >	����	 n  / >			 I   0 >��	���� @0 matchesinstring_options_range_ matchesInString_options_range_	 			 o   0 1���� 0 
asocstring 
asocString	 			 m   1 2����  	 	��	 J   2 :		 			 m   2 3����  	 	��	 n  3 8		 	 I   4 8�������� 
0 length  ��  ��  	  o   3 4���� 0 
asocstring 
asocString��  ��  ��  	 o   / 0���� 0 asocpattern asocPattern��  ��  	 o      ����  0 asocmatcharray asocMatchArray	 	!	"	! r   A E	#	$	# J   A C����  	$ o      ���� 0 resulttexts resultTexts	" 	%	&	% r   F I	'	(	' m   F G����  	( o      ���� 0 
startindex 
startIndex	& 	)	*	) Y   J	+��	,	-��	+ k   Z	.	. 	/	0	/ r   Z g	1	2	1 l  Z e	3����	3 n  Z e	4	5	4 I   ` e��	6���� 0 rangeatindex_ rangeAtIndex_	6 	7��	7 m   ` a����  ��  ��  	5 l  Z `	8����	8 n  Z `	9	:	9 I   [ `��	;����  0 objectatindex_ objectAtIndex_	; 	<��	< o   [ \���� 0 i  ��  ��  	: o   Z [����  0 asocmatcharray asocMatchArray��  ��  ��  ��  	2 o      ���� 0 
matchrange 
matchRange	0 	=	>	= r   h �	?	@	? c   h }	A	B	A l  h y	C����	C n  h y	D	E	D I   i y��	F���� *0 substringwithrange_ substringWithRange_	F 	G��	G K   i u	H	H ��	I	J�� 0 location  	I o   j k���� 0 
startindex 
startIndex	J ��	K���� 
0 length  	K l  l s	L����	L \   l s	M	N	M l  l q	O����	O n  l q	P	Q	P I   m q�������� 0 location  ��  ��  	Q o   l m���� 0 
matchrange 
matchRange��  ��  	N o   q r���� 0 
startindex 
startIndex��  ��  ��  ��  ��  	E o   h i���� 0 
asocstring 
asocString��  ��  	B m   y |��
�� 
ctxt	@ n      	R	S	R  ;   ~ 	S o   } ~���� 0 resulttexts resultTexts	> 	T	U	T r   � �	V	W	V c   � �	X	Y	X l  � �	Z����	Z n  � �	[	\	[ I   � ���	]���� *0 substringwithrange_ substringWithRange_	] 	^��	^ o   � ����� 0 
matchrange 
matchRange��  ��  	\ o   � ����� 0 
asocstring 
asocString��  ��  	Y m   � ���
�� 
ctxt	W o      ���� 0 thetoken theToken	U 	_	`	_ Z   � �	a	b��	c	a =  � �	d	e	d n  � �	f	g	f 4   � ���	h
�� 
cha 	h m   � ����� 	g o   � ����� 0 thetoken theToken	e m   � �	i	i �	j	j  \	b l  � �	k	l	m	k l  � �	n	o	p	n r   � �	q	r	q n  � �	s	t	s 4   � ���	u
�� 
cha 	u m   � ����� 	t o   � ����� 0 thetoken theToken	r n      	v	w	v  ;   � �	w o   � ����� 0 resulttexts resultTexts	o w q �so insert the character that follows it -- TO DO: should this support 'special' character escapes, \t, \n, etc?   	p �	x	x �   & s o   i n s e r t   t h e   c h a r a c t e r   t h a t   f o l l o w s   i t   - -   T O   D O :   s h o u l d   t h i s   s u p p o r t   ' s p e c i a l '   c h a r a c t e r   e s c a p e s ,   \ t ,   \ n ,   e t c ?	l + % found a backslash-escaped character�   	m �	y	y J   f o u n d   a   b a c k s l a s h - e s c a p e d   c h a r a c t e r &��  	c l  � �	z	{	|	z k   � �	}	} 	~		~ r   � �	�	�	� c   � �	�	�	� n  � �	�	�	� 4   � ���	�
�� 
cha 	� m   � ����� 	� o   � ����� 0 thetoken theToken	� m   � ���
�� 
long	� o      ���� 0 	itemindex 	itemIndex	 	�	�	� l  � �	�	�	�	� r   � �	�	�	� n   � �	�	�	� 4   � ���	�
�� 
cobj	� o   � ����� 0 	itemindex 	itemIndex	� o   � ����� 0 	thevalues 	theValues	� o      ���� 0 theitem theItem	� < 6 raises error -1728 if itemIndex > length of theValues   	� �	�	� l   r a i s e s   e r r o r   - 1 7 2 8   i f   i t e m I n d e x   >   l e n g t h   o f   t h e V a l u e s	� 	���	� Q   � �	�	�	�	� r   � �	�	�	� c   � �	�	�	� o   � ����� 0 theitem theItem	� m   � ���
�� 
ctxt	� n      	�	�	�  ;   � �	� o   � ����� 0 resulttexts resultTexts	� R      ����	�
�� .ascrerr ****      � ****��  	� ��	���
�� 
errn	� d      	�	� m      �������  	� R   � ��	�	�
� .ascrerr ****      � ****	� b   � �	�	�	� b   � �	�	�	� m   � �	�	� �	�	� & C a n  t   c o n v e r t   i t e m  	� o   � ��~�~ 0 	itemindex 	itemIndex	� m   � �	�	� �	�	�    t o   t e x t .	� �}	�	�
�} 
errn	� m   � ��|�|�\	� �{	�	�
�{ 
erob	� l  � �	��z�y	� N   � �	�	� n   � �	�	�	� 4   � ��x	�
�x 
cobj	� o   � ��w�w 0 	itemindex 	itemIndex	� o   � ��v�v 0 	thevalues 	theValues�z  �y  	� �u	��t
�u 
errt	� m   � ��s
�s 
ctxt�t  ��  	{  	 found $n   	| �	�	�    f o u n d   $ n	` 	��r	� r   �	�	�	� [   � 	�	�	� l  � �	��q�p	� n  � �	�	�	� I   � ��o�n�m�o 0 location  �n  �m  	� o   � ��l�l 0 
matchrange 
matchRange�q  �p  	� l  � �	��k�j	� n  � �	�	�	� I   � ��i�h�g�i 
0 length  �h  �g  	� o   � ��f�f 0 
matchrange 
matchRange�k  �j  	� o      �e�e 0 
startindex 
startIndex�r  �� 0 i  	, m   M N�d�d  	- l  N U	��c�b	� \   N U	�	�	� l  N S	��a�`	� n  N S	�	�	� I   O S�_�^�]�_ 	0 count  �^  �]  	� o   N O�\�\  0 asocmatcharray asocMatchArray�a  �`  	� m   S T�[�[ �c  �b  ��  	* 	�	�	� r  	�	�	� c  	�	�	� l 	��Z�Y	� n 	�	�	� I  	�X	��W�X *0 substringfromindex_ substringFromIndex_	� 	��V	� o  	
�U�U 0 
startindex 
startIndex�V  �W  	� o  	�T�T 0 
asocstring 
asocString�Z  �Y  	� m  �S
�S 
ctxt	� n      	�	�	�  ;  	� o  �R�R 0 resulttexts resultTexts	� 	�	�	� r  	�	�	� n 	�	�	� 1  �Q
�Q 
txdl	� 1  �P
�P 
ascr	� o      �O�O 0 oldtids oldTIDs	� 	�	�	� r   +	�	�	� m   #	�	� �	�	�  	� n     	�	�	� 1  &*�N
�N 
txdl	� 1  #&�M
�M 
ascr	� 	�	�	� r  ,3	�	�	� c  ,1	�	�	� o  ,-�L�L 0 resulttexts resultTexts	� m  -0�K
�K 
ctxt	� o      �J�J 0 
resulttext 
resultText	� 	�	�	� r  4=	�	�	� o  45�I�I 0 oldtids oldTIDs	� n     	�	�	� 1  8<�H
�H 
txdl	� 1  58�G
�G 
ascr	� 	��F	� L  >@	�	� o  >?�E�E 0 
resulttext 
resultText�F  � �D	�
�D conscase	� �C	�
�C consdiac	� �B	�
�B conshyph	� �A	�
�A conspunc	� �@�?
�@ conswhit�?  � �>�=
�> consnume�=  � R      �<	�	�
�< .ascrerr ****      � ****	� o      �;�; 0 etext eText	� �:	�	�
�: 
errn	� o      �9�9 0 enumber eNumber	� �8	�	�
�8 
erob	� o      �7�7 0 efrom eFrom	� �6	��5
�6 
errt	� o      �4�4 
0 eto eTo�5  � I  I[�3	��2�3 
0 _error  	� 	�	�	� m  JM	�	� �	�	�  f o r m a t   t e x t	� 	�	�	� o  MN�1�1 0 etext eText	� 
 

  o  NO�0�0 0 enumber eNumber
 


 o  OR�/�/ 0 efrom eFrom
 
�.
 o  RU�-�- 
0 eto eTo�.  �2  ��  � 


 l     �,�+�*�,  �+  �*  
 


 l     �)�(�'�)  �(  �'  
 
	


	 i  [ ^


 I     �&


�& .Txt:Normnull���     ctxt
 o      �%�% 0 thetext theText
 �$


�$ 
NoFo
 |�#�"
�!
�#  �"  
 o      � �  0 nopts nOpts�!  
 J      

 
�
 m      �
� LiBrLiOX�  
 �
�
� 
Loca
 |��
�
�  �  
 o      �� 0 
localecode 
localeCode�  
 l     
��
 m      

 �

  n o n e�  �  �  
 Q    �



 k   �

 

 
 r    
!
"
! n   
#
$
# I    �
%�� "0 astextparameter asTextParameter
% 
&
'
& o    	�� 0 thetext theText
' 
(�
( m   	 

)
) �
*
*  �  �  
$ o    �� 0 _support  
" o      �� 0 thetext theText
  
+
,
+ r    
-
.
- n   
/
0
/ I    �
1�� 0 aslist asList
1 
2�
2 o    �� 0 nopts nOpts�  �  
0 o    �� 0 _support  
. o      �
�
 0 nopts nOpts
, 
3
4
3 l   �	
5
6�	  
5   common case shortcuts   
6 �
7
7 ,   c o m m o n   c a s e   s h o r t c u t s
4 
8
9
8 Z   ,
:
;��
: =    #
<
=
< n   !
>
?
> 1    !�
� 
leng
? o    �� 0 thetext theText
= m   ! "��  
; L   & (
@
@ m   & '
A
A �
B
B  �  �  
9 
C
D
C Z  - C
E
F��
E =  - 2
G
H
G o   - .�� 0 nopts nOpts
H J   . 1
I
I 
J� 
J m   . /��
�� LiBrLiOX�   
F L   5 ?
K
K I   5 >��
L���� 0 	_jointext 	_joinText
L 
M
N
M n  6 9
O
P
O 2  7 9��
�� 
cpar
P o   6 7���� 0 thetext theText
N 
Q��
Q 1   9 :��
�� 
lnfd��  ��  �  �  
D 
R
S
R Z  D Q
T
U����
T =  D H
V
W
V o   D E���� 0 nopts nOpts
W J   E G����  
U L   K M
X
X o   K L���� 0 thetext theText��  ��  
S 
Y
Z
Y l  R R��
[
\��  
[ &   else fully process options list   
\ �
]
] @   e l s e   f u l l y   p r o c e s s   o p t i o n s   l i s t
Z 
^
_
^ Q   R�
`
a
b
` k   U�
c
c 
d
e
d Z   U f
f
g��
h
f E  U Z
i
j
i o   U V���� 0 nopts nOpts
j J   V Y
k
k 
l��
l m   V W��
�� LiBrLiOX��  
g r   ] `
m
n
m 1   ] ^��
�� 
lnfd
n o      ���� 0 	linebreak 	lineBreak��  
h r   c f
o
p
o m   c d��
�� 
msng
p o      ���� 0 	linebreak 	lineBreak
e 
q
r
q Z   g �
s
t����
s E  g l
u
v
u o   g h���� 0 nopts nOpts
v J   h k
w
w 
x��
x m   h i��
�� LiBrLiCM��  
t k   o �
y
y 
z
{
z Z  o 
|
}����
| >  o r
~

~ o   o p���� 0 	linebreak 	lineBreak
 m   p q��
�� 
msng
} R   u {��
�
�
�� .ascrerr ****      � ****
� m   y z
�
� �
�
� 6 t o o   m a n y   l i n e   b r e a k   o p t i o n s
� ��
���
�� 
errn
� m   w x����f��  ��  ��  
{ 
�
�
� Z  � �
�
�����
� =   � �
�
�
� n  � �
�
�
� 1   � ���
�� 
leng
� o   � ����� 0 nopts nOpts
� m   � ����� 
� L   � �
�
� I   � ���
����� 0 	_jointext 	_joinText
� 
�
�
� n  � �
�
�
� 2  � ���
�� 
cpar
� o   � ����� 0 thetext theText
� 
���
� o   � ���
�� 
ret ��  ��  ��  ��  
� 
���
� r   � �
�
�
� o   � ���
�� 
ret 
� o      ���� 0 	linebreak 	lineBreak��  ��  ��  
r 
�
�
� Z   � �
�
�����
� E  � �
�
�
� o   � ����� 0 nopts nOpts
� J   � �
�
� 
���
� m   � ���
�� LiBrLiWi��  
� k   � �
�
� 
�
�
� Z  � �
�
�����
� >  � �
�
�
� o   � ����� 0 	linebreak 	lineBreak
� m   � ���
�� 
msng
� R   � ���
�
�
�� .ascrerr ****      � ****
� m   � �
�
� �
�
� 6 t o o   m a n y   l i n e   b r e a k   o p t i o n s
� ��
���
�� 
errn
� m   � �����f��  ��  ��  
� 
�
�
� Z  � �
�
�����
� =   � �
�
�
� n  � �
�
�
� 1   � ���
�� 
leng
� o   � ����� 0 nopts nOpts
� m   � ����� 
� L   � �
�
� I   � ���
����� 0 	_jointext 	_joinText
� 
�
�
� n  � �
�
�
� 2  � ���
�� 
cpar
� o   � ����� 0 thetext theText
� 
���
� b   � �
�
�
� o   � ���
�� 
ret 
� 1   � ���
�� 
lnfd��  ��  ��  ��  
� 
���
� r   � �
�
�
� b   � �
�
�
� o   � ���
�� 
ret 
� 1   � ���
�� 
lnfd
� o      ���� 0 	linebreak 	lineBreak��  ��  ��  
� 
�
�
� r   � �
�
�
� n  � �
�
�
� I   � ���
����� 0 
asnsstring 
asNSString
� 
���
� o   � ����� 0 thetext theText��  ��  
� o   � ����� 0 _support  
� o      ���� 0 
asocstring 
asocString
� 
�
�
� l  � ���
�
���  
� , & fold case, diacriticals, and/or width   
� �
�
� L   f o l d   c a s e ,   d i a c r i t i c a l s ,   a n d / o r   w i d t h
� 
�
�
� r   � �
�
�
� m   � �����  
� o      ���� 0 foldingflags foldingFlags
� 
�
�
� Z  �
�
�����
� E  � �
�
�
� o   � ����� 0 nopts nOpts
� J   � �
�
� 
���
� m   � ���
�� NoFoNoCa��  
� r   � �
�
�
� [   � �
�
�
� o   � ����� 0 foldingflags foldingFlags
� m   � ����� 
� o      ���� 0 foldingflags foldingFlags��  ��  
� 
�
�
� Z 
�
�����
� E 	
�
�
� o  ���� 0 nopts nOpts
� J  
�
� 
���
� m  ��
�� NoFoNoDi��  
� r  
�
�
� [  
�
�
� o  ���� 0 foldingflags foldingFlags
� m  ���� �
� o      ���� 0 foldingflags foldingFlags��  ��  
� 
�
�
� Z -
�
�����
� E 
�
�
� o  ���� 0 nopts nOpts
� J  
�
� 
���
� m  ��
�� NoFoNoWi��  
� r  ")
�
�
� [  "'
�
�
� o  "#���� 0 foldingflags foldingFlags
� m  #&���� 
� o      ���� 0 foldingflags foldingFlags��  ��  
� 
�
�
� Z .M
�
�����
� >  .1
�
�
� o  ./���� 0 foldingflags foldingFlags
� m  /0����  
� r  4I
�
�
� n 4G
�
�
� I  5G�� ���� H0 "stringbyfoldingwithoptions_locale_ "stringByFoldingWithOptions_locale_   o  56���� 0 foldingflags foldingFlags �� l 6C���� n 6C I  ;C������ *0 asnslocaleparameter asNSLocaleParameter 	 o  ;<���� 0 
localecode 
localeCode	 
��
 m  <? �  f o r   l o c a l e��  ��   o  6;���� 0 _support  ��  ��  ��  ��  
� o  45���� 0 
asocstring 
asocString
� o      ���� 0 
asocstring 
asocString��  ��  
�  l NN����   !  normalize white space runs    � 6   n o r m a l i z e   w h i t e   s p a c e   r u n s  Z  N�� E NU o  NO�~�~ 0 nopts nOpts J  OT �} m  OR�|
�| NoFoNoSp�}   l X� Z  X��{  = X[!"! o  XY�z�z 0 	linebreak 	lineBreak" m  YZ�y
�y 
msng l ^|#$%# r  ^|&'& n ^z()( I  _z�x*�w�x �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_* +,+ m  _b-- �.. @ ( ? : \ r \ n | \ r | \ n | \ u 2 0 2 8 | \ u 2 0 2 9 | \ s ) +, /0/ 1  be�v
�v 
spac0 121 l el3�u�t3 n el454 o  hl�s�s 60 nsregularexpressionsearch NSRegularExpressionSearch5 m  eh�r
�r misccura�u  �t  2 6�q6 J  lt77 898 m  lm�p�p  9 :�o: n mr;<; I  nr�n�m�l�n 
0 length  �m  �l  < o  mn�k�k 0 
asocstring 
asocString�o  �q  �w  ) o  ^_�j�j 0 
asocstring 
asocString' o      �i�i 0 
asocstring 
asocString$ b \ also convert line breaks (including Unicode line and paragraph separators) to single spaces   % �== �   a l s o   c o n v e r t   l i n e   b r e a k s   ( i n c l u d i n g   U n i c o d e   l i n e   a n d   p a r a g r a p h   s e p a r a t o r s )   t o   s i n g l e   s p a c e s�{    l �>?@> k  �AA BCB r  �DED n �FGF I  ���hH�g�h �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_H IJI m  ��KK �LL N ( ? : \ s * ( ? : \ r \ n | \ r | \ n | \ u 2 0 2 8 | \ u 2 0 2 9 ) ) + \ s *J MNM o  ���f�f 0 	linebreak 	lineBreakN OPO l ��Q�e�dQ n ��RSR o  ���c�c 60 nsregularexpressionsearch NSRegularExpressionSearchS m  ���b
�b misccura�e  �d  P T�aT J  ��UU VWV m  ���`�`  W X�_X n ��YZY I  ���^�]�\�^ 
0 length  �]  �\  Z o  ���[�[ 0 
asocstring 
asocString�_  �a  �g  G o  ��Z�Z 0 
asocstring 
asocStringE o      �Y�Y 0 
asocstring 
asocStringC [�X[ r  ��\]\ n ��^_^ I  ���W`�V�W �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_` aba m  ��cc �dd  [ \ f \ t \ p { Z } ] +b efe 1  ���U
�U 
spacf ghg l ��i�T�Si n ��jkj o  ���R�R 60 nsregularexpressionsearch NSRegularExpressionSearchk m  ���Q
�Q misccura�T  �S  h l�Pl J  ��mm non m  ���O�O  o p�Np n ��qrq I  ���M�L�K�M 
0 length  �L  �K  r o  ���J�J 0 
asocstring 
asocString�N  �P  �V  _ o  ���I�I 0 
asocstring 
asocString] o      �H�H 0 
asocstring 
asocString�X  ? � � convert line break runs (including any other white space) to single `lineBreak`, and any other white space runs (tabs, spaces, etc) to single spaces   @ �ss*   c o n v e r t   l i n e   b r e a k   r u n s   ( i n c l u d i n g   a n y   o t h e r   w h i t e   s p a c e )   t o   s i n g l e   ` l i n e B r e a k ` ,   a n d   a n y   o t h e r   w h i t e   s p a c e   r u n s   ( t a b s ,   s p a c e s ,   e t c )   t o   s i n g l e   s p a c e s J D note: this does not automatically trim leading/trailing white space    �tt �   n o t e :   t h i s   d o e s   n o t   a u t o m a t i c a l l y   t r i m   l e a d i n g / t r a i l i n g   w h i t e   s p a c e uvu > ��wxw o  ���G�G 0 	linebreak 	lineBreakx m  ���F
�F 
msngv y�Ey l ��z{|z r  ��}~} n ��� I  ���D��C�D �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_� ��� m  ���� ��� 0 \ r \ n | \ r | \ n | \ u 2 0 2 8 | \ u 2 0 2 9� ��� o  ���B�B 0 	linebreak 	lineBreak� ��� l ����A�@� n ����� o  ���?�? 60 nsregularexpressionsearch NSRegularExpressionSearch� m  ���>
�> misccura�A  �@  � ��=� J  ���� ��� m  ���<�<  � ��;� n ����� I  ���:�9�8�: 
0 length  �9  �8  � o  ���7�7 0 
asocstring 
asocString�;  �=  �C  � o  ���6�6 0 
asocstring 
asocString~ o      �5�5 0 
asocstring 
asocString{   standardize line breaks   | ��� 0   s t a n d a r d i z e   l i n e   b r e a k s�E  �   ��� l ���4���4  � 6 0 convert to specified Unicode normalization form   � ��� `   c o n v e r t   t o   s p e c i f i e d   U n i c o d e   n o r m a l i z a t i o n   f o r m� ��� Z  �����3�� E ����� o  ���2�2 0 nopts nOpts� J  ���� ��1� m  ���0
�0 NoFoNo_C�1  � k  ���� ��� r  ����� n ����� I  ���/�.�-�/ N0 %precomposedstringwithcanonicalmapping %precomposedStringWithCanonicalMapping�.  �-  � o  ���,�, 0 
asocstring 
asocString� o      �+�+ 0 
asocstring 
asocString� ��*� r  ����� m  ���)
�) boovtrue� o      �(�( 0 didnormalize didNormalize�*  �3  � r  ����� m  ���'
�' boovfals� o      �&�& 0 didnormalize didNormalize� ��� Z   *���%�$� E  ��� o   �#�# 0 nopts nOpts� J  �� ��"� m  �!
�! NoFoNo_D�"  � k  
&�� ��� Z 
��� �� o  
�� 0 didnormalize didNormalize� R  ���
� .ascrerr ****      � ****� m  �� ��� : t o o   m a n y   U n i c o d e   f o r m   o p t i o n s� ���
� 
errn� m  ��f�  �   �  � ��� r  "��� n  ��� I   ���� L0 $decomposedstringwithcanonicalmapping $decomposedStringWithCanonicalMapping�  �  � o  �� 0 
asocstring 
asocString� o      �� 0 
asocstring 
asocString� ��� r  #&��� m  #$�
� boovtrue� o      �� 0 didnormalize didNormalize�  �%  �$  � ��� Z  +U����� E +2��� o  +,�� 0 nopts nOpts� J  ,1�� ��� m  ,/�
� NoFoNoKC�  � k  5Q�� ��� Z 5E����� o  56�
�
 0 didnormalize didNormalize� R  9A�	��
�	 .ascrerr ****      � ****� m  =@�� ��� : t o o   m a n y   U n i c o d e   f o r m   o p t i o n s� ���
� 
errn� m  ;<��f�  �  �  � ��� r  FM��� n FK��� I  GK���� V0 )precomposedstringwithcompatibilitymapping )precomposedStringWithCompatibilityMapping�  �  � o  FG�� 0 
asocstring 
asocString� o      �� 0 
asocstring 
asocString� �� � r  NQ��� m  NO��
�� boovtrue� o      ���� 0 didnormalize didNormalize�   �  �  � ���� Z  V�������� E V]��� o  VW���� 0 nopts nOpts� J  W\�� ���� m  WZ��
�� NoFoNoKD��  � k  `|�� ��� Z `p������� o  `a���� 0 didnormalize didNormalize� R  dl����
�� .ascrerr ****      � ****� m  hk�� ��� : t o o   m a n y   U n i c o d e   f o r m   o p t i o n s� �����
�� 
errn� m  fg����f��  ��  ��  � ��� r  qx��� n qv��� I  rv�������� T0 (decomposedstringwithcompatibilitymapping (decomposedStringWithCompatibilityMapping��  ��  � o  qr���� 0 
asocstring 
asocString� o      ���� 0 
asocstring 
asocString� ���� r  y|��� m  yz��
�� boovtrue� o      ���� 0 didnormalize didNormalize��  ��  ��  ��  
a R      ��� 
�� .ascrerr ****      � ****� o      ���� 0 etext eText  ����
�� 
errn m      ����f��  
b n �� I  �������� .0 throwinvalidparameter throwInvalidParameter  o  ������ 0 nopts nOpts  m  ��		 �

 
 u s i n g  m  ����
�� 
list �� o  ������ 0 etext eText��  ��   o  ������ 0 _support  
_ �� L  �� c  �� o  ������ 0 
asocstring 
asocString m  ����
�� 
ctxt��  
 R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  
 I  �������� 
0 _error    m  �� �  n o r m a l i z e   t e x t  o  ������ 0 etext eText  !  o  ������ 0 enumber eNumber! "#" o  ������ 0 efrom eFrom# $��$ o  ������ 
0 eto eTo��  ��  

 %&% l     ��������  ��  ��  & '(' l     ��������  ��  ��  ( )*) i  _ b+,+ I     ��-.
�� .Txt:PadTnull���     ctxt- o      ���� 0 thetext theText. ��/0
�� 
toPl/ o      ���� 0 	textwidth 	textWidth0 ��12
�� 
Char1 |����3��4��  ��  3 o      ���� 0 padtext padText��  4 l     5����5 m      66 �77                                  ��  ��  2 ��8��
�� 
From8 |����9��:��  ��  9 o      ���� 0 whichend whichEnd��  : l     ;����; m      ��
�� LeTrLCha��  ��  ��  , Q    <=>< k    �?? @A@ r    BCB n   DED I    ��F���� "0 astextparameter asTextParameterF GHG o    	���� 0 thetext theTextH I��I m   	 
JJ �KK  ��  ��  E o    ���� 0 _support  C o      ���� 0 thetext theTextA LML r    NON n   PQP I    ��R���� (0 asintegerparameter asIntegerParameterR STS o    ���� 0 	textwidth 	textWidthT U��U m    VV �WW  t o   p l a c e s��  ��  Q o    ���� 0 _support  O o      ���� 0 	textwidth 	textWidthM XYX r    &Z[Z \    $\]\ o     ���� 0 	textwidth 	textWidth] l    #^����^ n    #_`_ 1   ! #��
�� 
leng` o     !���� 0 thetext theText��  ��  [ o      ���� 0 
widthtoadd 
widthToAddY aba Z  ' 3cd����c B   ' *efe o   ' (���� 0 
widthtoadd 
widthToAddf m   ( )����  d L   - /gg o   - .���� 0 thetext theText��  ��  b hih r   4 Ajkj n  4 ?lml I   9 ?��n���� "0 astextparameter asTextParametern opo o   9 :���� 0 padtext padTextp q��q m   : ;rr �ss 
 u s i n g��  ��  m o   4 9���� 0 _support  k o      ���� 0 padtext padTexti tut r   B Gvwv n  B Exyx 1   C E��
�� 
lengy o   B C���� 0 padtext padTextw o      ���� 0 padsize padSizeu z{z Z  H \|}����| =   H M~~ n  H K��� 1   I K��
�� 
leng� o   H I���� 0 padtext padText m   K L����  } R   P X����
�� .ascrerr ****      � ****� m   V W�� ��� f I n v a l i d    u s i n g    p a r a m e t e r   ( e m p t y   t e x t   n o t   a l l o w e d ) .� ����
�� 
errn� m   R S�����Y� �����
�� 
erob� o   T U���� 0 padtext padText��  ��  ��  { ��� V   ] s��� r   i n��� b   i l��� o   i j���� 0 padtext padText� o   j k���� 0 padtext padText� o      ���� 0 padtext padText� A   a h��� n  a d��� 1   b d��
�� 
leng� o   a b���� 0 padtext padText� l  d g���~� [   d g��� o   d e�}�} 0 
widthtoadd 
widthToAdd� o   e f�|�| 0 padsize padSize�  �~  � ��{� Z   t ������ =  t w��� o   t u�z�z 0 whichend whichEnd� m   u v�y
�y LeTrLCha� L   z ��� b   z ���� l  z ���x�w� n  z ���� 7  { ��v��
�v 
ctxt� m    ��u�u � o   � ��t�t 0 
widthtoadd 
widthToAdd� o   z {�s�s 0 padtext padText�x  �w  � o   � ��r�r 0 thetext theText� ��� =  � ���� o   � ��q�q 0 whichend whichEnd� m   � ��p
�p LeTrTCha� ��� k   � ��� ��� r   � ���� `   � ���� l  � ���o�n� n  � ���� 1   � ��m
�m 
leng� o   � ��l�l 0 thetext theText�o  �n  � o   � ��k�k 0 padsize padSize� o      �j�j 0 	padoffset 	padOffset� ��i� L   � ��� b   � ���� o   � ��h�h 0 thetext theText� l  � ���g�f� n  � ���� 7  � ��e��
�e 
ctxt� l  � ���d�c� [   � ���� m   � ��b�b � o   � ��a�a 0 	padoffset 	padOffset�d  �c  � l  � ���`�_� [   � ���� o   � ��^�^ 0 	padoffset 	padOffset� o   � ��]�] 0 
widthtoadd 
widthToAdd�`  �_  � o   � ��\�\ 0 padtext padText�g  �f  �i  � ��� =  � ���� o   � ��[�[ 0 whichend whichEnd� m   � ��Z
�Z LeTrBCha� ��Y� k   � ��� ��� Z  � ����X�W� ?   � ���� o   � ��V�V 0 
widthtoadd 
widthToAdd� m   � ��U�U � r   � ���� b   � ���� n  � ���� 7  � ��T��
�T 
ctxt� m   � ��S�S � l  � ���R�Q� _   � ���� o   � ��P�P 0 
widthtoadd 
widthToAdd� m   � ��O�O �R  �Q  � o   � ��N�N 0 padtext padText� o   � ��M�M 0 thetext theText� o      �L�L 0 thetext theText�X  �W  � ��� r   � ���� `   � ���� l  � ���K�J� n  � ���� 1   � ��I
�I 
leng� o   � ��H�H 0 thetext theText�K  �J  � o   � ��G�G 0 padsize padSize� o      �F�F 0 	padoffset 	padOffset� ��E� L   � ��� b   � ���� o   � ��D�D 0 thetext theText� l  � ���C�B� n  � ���� 7  � ��A��
�A 
ctxt� l  � ���@�?� [   � ���� m   � ��>�> � o   � ��=�= 0 	padoffset 	padOffset�@  �?  � l  � ���<�;� [   � ���� o   � ��:�: 0 	padoffset 	padOffset� _   � ���� l  � ���9�8� [   � ���� o   � ��7�7 0 
widthtoadd 
widthToAdd� m   � ��6�6 �9  �8  � m   � ��5�5 �<  �;  � o   � ��4�4 0 padtext padText�C  �B  �E  �Y  � n  � ���� I   � ��3��2�3 >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   � ��1�1 0 whichend whichEnd� ��0� m   � �   �  a d d i n g�0  �2  � o   � ��/�/ 0 _support  �{  = R      �.
�. .ascrerr ****      � **** o      �-�- 0 etext eText �,
�, 
errn o      �+�+ 0 enumber eNumber �*
�* 
erob o      �)�) 0 efrom eFrom �(�'
�( 
errt o      �&�& 
0 eto eTo�'  > I  �%	�$�% 
0 _error  	 

 m   �  p a d   t e x t  o  	�#�# 0 etext eText  o  	
�"�" 0 enumber eNumber  o  
�!�! 0 efrom eFrom �  o  �� 
0 eto eTo�   �$  *  l     ����  �  �    l     ����  �  �    i  c f I     �
� .Txt:SliTnull���     ctxt o      �� 0 thetext theText � 
� 
FIdx |��!�"�  �  ! o      �� 0 
startindex 
startIndex�  " l     #��# m      �
� 
msng�  �    �$�
� 
TIdx$ |��%�
&�  �  % o      �	�	 0 endindex endIndex�
  & l     '��' m      �
� 
msng�  �  �   Q    �()*( k   �++ ,-, r    ./. n   010 I    �2�� "0 astextparameter asTextParameter2 343 o    	�� 0 thetext theText4 5�5 m   	 
66 �77  �  �  1 o    �� 0 _support  / o      � �  0 thetext theText- 898 r    :;: n   <=< 1    ��
�� 
leng= o    ���� 0 thetext theText; o      ���� 0 	thelength 	theLength9 >?> Z    I@A����@ =    BCB o    ���� 0 	thelength 	theLengthC m    ����  A k    EDD EFE l   ��GH��  G � � note: index 0 is always disallowed as its position is ambiguous, being both before index 1 at start of text and after index -1 at end of text   H �II   n o t e :   i n d e x   0   i s   a l w a y s   d i s a l l o w e d   a s   i t s   p o s i t i o n   i s   a m b i g u o u s ,   b e i n g   b o t h   b e f o r e   i n d e x   1   a t   s t a r t   o f   t e x t   a n d   a f t e r   i n d e x   - 1   a t   e n d   o f   t e x tF JKJ Z   /LM����L =     NON o    ���� 0 
startindex 
startIndexO m    ����  M R   # +��PQ
�� .ascrerr ****      � ****P m   ) *RR �SS Z I n v a l i d   i n d e x   (  f r o m    p a r a m e t e r   c a n n o t   b e   0 ) .Q ��TU
�� 
errnT m   % &�����YU ��V��
�� 
erobV o   ' (���� 0 
startindex 
startIndex��  ��  ��  K WXW Z  0 BYZ����Y =   0 3[\[ o   0 1���� 0 endindex endIndex\ m   1 2����  Z R   6 >��]^
�� .ascrerr ****      � ****] m   < =__ �`` V I n v a l i d   i n d e x   (  t o    p a r a m e t e r   c a n n o t   b e   0 ) .^ ��ab
�� 
errna m   8 9�����Yb ��c��
�� 
erobc o   : ;���� 0 endindex endIndex��  ��  ��  X d��d L   C Eee m   C Dff �gg  ��  ��  ��  ? hih Z   J �jkl��j >  J Mmnm o   J K���� 0 
startindex 
startIndexn m   K L��
�� 
msngk k   P �oo pqp r   P ]rsr n  P [tut I   U [��v���� (0 asintegerparameter asIntegerParameterv wxw o   U V���� 0 
startindex 
startIndexx y��y m   V Wzz �{{  f r o m��  ��  u o   P U���� 0 _support  s o      ���� 0 
startindex 
startIndexq |}| Z  ^ p~����~ =   ^ a��� o   ^ _���� 0 
startindex 
startIndex� m   _ `����   R   d l����
�� .ascrerr ****      � ****� m   j k�� ��� Z I n v a l i d   i n d e x   (  f r o m    p a r a m e t e r   c a n n o t   b e   0 ) .� ����
�� 
errn� m   f g�����Y� �����
�� 
erob� o   h i���� 0 
startindex 
startIndex��  ��  ��  } ���� Z   q �������� =  q t��� o   q r���� 0 endindex endIndex� m   r s��
�� 
msng� Z   w ������ A   w {��� o   w x���� 0 
startindex 
startIndex� d   x z�� o   x y���� 0 	thelength 	theLength� L   ~ ��� o   ~ ���� 0 thetext theText� ��� ?   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 	thelength 	theLength� ���� L   � ��� m   � ��� ���  ��  � L   � ��� n  � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� m   � �������� o   � ����� 0 thetext theText��  ��  ��  l ��� =  � ���� o   � ����� 0 endindex endIndex� m   � ���
�� 
msng� ���� R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� J M i s s i n g    f r o m    a n d / o r    t o    p a r a m e t e r .� �����
�� 
errn� m   � ������[��  ��  ��  i ��� Z   �������� >  � ���� o   � ����� 0 endindex endIndex� m   � ���
�� 
msng� k   ��� ��� r   � ���� n  � ���� I   � �������� (0 asintegerparameter asIntegerParameter� ��� o   � ����� 0 endindex endIndex� ���� m   � ��� ���  t o��  ��  � o   � ����� 0 _support  � o      ���� 0 endindex endIndex� ��� Z  � �������� =   � ���� o   � ����� 0 endindex endIndex� m   � �����  � R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� V I n v a l i d   i n d e x   (  t o    p a r a m e t e r   c a n n o t   b e   0 ) .� ����
�� 
errn� m   � ������Y� �����
�� 
erob� o   � ����� 0 endindex endIndex��  ��  ��  � ���� Z   �������� =  � ���� o   � ����� 0 
startindex 
startIndex� m   � ���
�� 
msng� Z   ������ A   � ���� o   � ����� 0 endindex endIndex� d   � ��� o   � ����� 0 	thelength 	theLength� L   � ��� m   � ��� ���  � ��� ?   � ���� o   � ����� 0 endindex endIndex� o   � ����� 0 	thelength 	theLength� ���� L   � ��� o   � ����� 0 thetext theText��  � L  �� n ��� 7 ����
�� 
ctxt� m  ���� � o  	���� 0 endindex endIndex� o  ���� 0 thetext theText��  ��  ��  ��  ��  � ��� l ������  � + % both start and end indexes are given   � ��� J   b o t h   s t a r t   a n d   e n d   i n d e x e s   a r e   g i v e n� ��� Z (������� A  ��� o  ���� 0 
startindex 
startIndex� m  ����  � r  $��� [  "��� [   ��� o  ���� 0 	thelength 	theLength� m  ���� � o   !���� 0 
startindex 
startIndex� o      ���� 0 
startindex 
startIndex��  ��  � ��� Z ):������� A  ),��� o  )*���� 0 endindex endIndex� m  *+����  � r  /6��� [  /4   [  /2 o  /0���� 0 	thelength 	theLength m  01����  o  23���� 0 endindex endIndex� o      ���� 0 endindex endIndex��  ��  �  Z ;q���� G  ;f	 G  ;R

 ?  ;> o  ;<���� 0 
startindex 
startIndex o  <=���� 0 endindex endIndex F  AN A  AD o  AB���� 0 
startindex 
startIndex m  BC����  A  GJ o  GH�� 0 endindex endIndex l 
HI�~�} m  HI�|�| �~  �}  	 F  Ub ?  UX o  UV�{�{ 0 
startindex 
startIndex o  VW�z�z 0 	thelength 	theLength ?  [^ o  [\�y�y 0 endindex endIndex o  \]�x�x 0 	thelength 	theLength L  im m  il �  ��  ��    Z  r� !"�w  A  ru#$# o  rs�v�v 0 
startindex 
startIndex$ m  st�u�u ! r  x{%&% m  xy�t�t & o      �s�s 0 
startindex 
startIndex" '(' ?  ~�)*) o  ~�r�r 0 
startindex 
startIndex* o  ��q�q 0 	thelength 	theLength( +�p+ r  ��,-, o  ���o�o 0 	thelength 	theLength- o      �n�n 0 
startindex 
startIndex�p  �w   ./. Z  ��012�m0 A  ��343 o  ���l�l 0 endindex endIndex4 m  ���k�k 1 r  ��565 m  ���j�j 6 o      �i�i 0 endindex endIndex2 787 ?  ��9:9 o  ���h�h 0 endindex endIndex: o  ���g�g 0 	thelength 	theLength8 ;�f; r  ��<=< o  ���e�e 0 	thelength 	theLength= o      �d�d 0 endindex endIndex�f  �m  / >�c> L  ��?? n  ��@A@ 7 ���bBC
�b 
ctxtB o  ���a�a 0 
startindex 
startIndexC o  ���`�` 0 endindex endIndexA o  ���_�_ 0 thetext theText�c  ) R      �^DE
�^ .ascrerr ****      � ****D o      �]�] 0 etext eTextE �\FG
�\ 
errnF o      �[�[ 0 enumber eNumberG �ZHI
�Z 
erobH o      �Y�Y 0 efrom eFromI �XJ�W
�X 
errtJ o      �V�V 
0 eto eTo�W  * I  ���UK�T�U 
0 _error  K LML m  ��NN �OO  s l i c e   t e x tM PQP o  ���S�S 0 etext eTextQ RSR o  ���R�R 0 enumber eNumberS TUT o  ���Q�Q 0 efrom eFromU V�PV o  ���O�O 
0 eto eTo�P  �T   WXW l     �N�M�L�N  �M  �L  X YZY l     �K�J�I�K  �J  �I  Z [\[ i  g j]^] I     �H_`
�H .Txt:TrmTnull���     ctxt_ o      �G�G 0 thetext theText` �Fa�E
�F 
Froma |�D�Cb�Bc�D  �C  b o      �A�A 0 whichend whichEnd�B  c l     d�@�?d m      �>
�> LeTrBCha�@  �?  �E  ^ Q     �efge k    �hh iji r    klk n   mnm I    �=o�<�= "0 astextparameter asTextParametero pqp o    	�;�; 0 thetext theTextq r�:r m   	 
ss �tt  �:  �<  n o    �9�9 0 _support  l o      �8�8 0 thetext theTextj uvu Z    -wx�7�6w H    yy E   z{z J    || }~} m    �5
�5 LeTrLCha~ � m    �4
�4 LeTrTCha� ��3� m    �2
�2 LeTrBCha�3  { J    �� ��1� o    �0�0 0 whichend whichEnd�1  x n   )��� I   # )�/��.�/ >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o   # $�-�- 0 whichend whichEnd� ��,� m   $ %�� ���  r e m o v i n g�,  �.  � o    #�+�+ 0 _support  �7  �6  v ��*� P   . ����� k   3 ��� ��� l  3 ?���� Z  3 ?���)�(� =  3 6��� o   3 4�'�' 0 thetext theText� m   4 5�� ���  � L   9 ;�� m   9 :�� ���  �)  �(  � H B check if theText is empty or contains white space characters only   � ��� �   c h e c k   i f   t h e T e x t   i s   e m p t y   o r   c o n t a i n s   w h i t e   s p a c e   c h a r a c t e r s   o n l y� ��� r   @ S��� J   @ D�� ��� m   @ A�&�& � ��%� m   A B�$�$���%  � J      �� ��� o      �#�# 0 
startindex 
startIndex� ��"� o      �!�! 0 endindex endIndex�"  � ��� Z   T x��� �� E  T \��� J   T X�� ��� m   T U�
� LeTrLCha� ��� m   U V�
� LeTrBCha�  � J   X [�� ��� o   X Y�� 0 whichend whichEnd�  � V   _ t��� r   j o��� [   j m��� o   j k�� 0 
startindex 
startIndex� m   k l�� � o      �� 0 
startindex 
startIndex� =  c i��� n   c g��� 4   d g��
� 
cha � o   e f�� 0 
startindex 
startIndex� o   c d�� 0 thetext theText� m   g h�� ���  �   �  � ��� Z   y ������ E  y ���� J   y }�� ��� m   y z�
� LeTrTCha� ��� m   z {�
� LeTrBCha�  � J   } ��� ��� o   } ~�� 0 whichend whichEnd�  � V   � ���� r   � ���� \   � ���� o   � ��� 0 endindex endIndex� m   � ��� � o      �
�
 0 endindex endIndex� =  � ���� n   � ���� 4   � ��	�
�	 
cha � o   � ��� 0 endindex endIndex� o   � ��� 0 thetext theText� m   � ��� ���  �  �  � ��� L   � ��� n   � ���� 7  � ����
� 
ctxt� o   � ��� 0 
startindex 
startIndex� o   � ��� 0 endindex endIndex� o   � ��� 0 thetext theText�  � ��
� conscase� � �
�  consdiac� ���
�� conshyph� ����
�� conspunc��  � ���
�� consnume� ����
�� conswhit��  �*  f R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  g I   � �������� 
0 _error  � ��� m   � ��� ���  t r i m   t e x t� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  \ ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � � � l     ����   J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   l     ����     Split and Join Suite    � *   S p l i t   a n d   J o i n   S u i t e 	
	 l     ��������  ��  ��  
  i  k n I      ������ .0 _aslinebreakparameter _asLineBreakParameter  o      ���� 0 linebreaktype lineBreakType �� o      ���� 0 parametername parameterName��  ��   l    / Z     / =     o     ���� 0 linebreaktype lineBreakType m    ��
�� LiBrLiOX L    	 1    ��
�� 
lnfd  =     o    ���� 0 linebreaktype lineBreakType  m    ��
�� LiBrLiCM !"! L    ## o    ��
�� 
ret " $%$ =   &'& o    ���� 0 linebreaktype lineBreakType' m    ��
�� LiBrLiWi% (��( L    !)) b     *+* o    ��
�� 
ret + 1    ��
�� 
lnfd��   n  $ /,-, I   ) /��.���� >0 throwinvalidconstantparameter throwInvalidConstantParameter. /0/ o   ) *���� 0 linebreaktype lineBreakType0 1��1 o   * +���� 0 parametername parameterName��  ��  - o   $ )���� 0 _support   < 6 used by `join paragraphs` and `normalize line breaks`    �22 l   u s e d   b y   ` j o i n   p a r a g r a p h s `   a n d   ` n o r m a l i z e   l i n e   b r e a k s ` 343 l     ��������  ��  ��  4 565 l     ��������  ��  ��  6 787 i  o r9:9 I      ��;���� 0 
_splittext 
_splitText; <=< o      ���� 0 thetext theText= >��> o      ���� 0 theseparator theSeparator��  ��  : l    ^?@A? k     ^BB CDC r     EFE n    
GHG I    
��I���� 0 aslist asListI J��J o    ���� 0 theseparator theSeparator��  ��  H o     ���� 0 _support  F o      ���� 0 delimiterlist delimiterListD KLK X    CM��NM Q    >OPQO l    )RSTR r     )UVU c     %WXW n     #YZY 1   ! #��
�� 
pcntZ o     !���� 0 aref aRefX m   # $��
�� 
ctxtV n      [\[ 1   & (��
�� 
pcnt\ o   % &���� 0 aref aRefS�� caution: AS silently ignores invalid TID values, so separator items must be explicitly validated to catch any user errors; for now, just coerce to text and catch errors, but might want to make it more rigorous in future (e.g. if a list of lists is given, should sublist be treated as an error instead of just coercing it to text, which is itself TIDs sensitive); see also existing TODO on TypeSupport's asTextParameter handler   T �]]V   c a u t i o n :   A S   s i l e n t l y   i g n o r e s   i n v a l i d   T I D   v a l u e s ,   s o   s e p a r a t o r   i t e m s   m u s t   b e   e x p l i c i t l y   v a l i d a t e d   t o   c a t c h   a n y   u s e r   e r r o r s ;   f o r   n o w ,   j u s t   c o e r c e   t o   t e x t   a n d   c a t c h   e r r o r s ,   b u t   m i g h t   w a n t   t o   m a k e   i t   m o r e   r i g o r o u s   i n   f u t u r e   ( e . g .   i f   a   l i s t   o f   l i s t s   i s   g i v e n ,   s h o u l d   s u b l i s t   b e   t r e a t e d   a s   a n   e r r o r   i n s t e a d   o f   j u s t   c o e r c i n g   i t   t o   t e x t ,   w h i c h   i s   i t s e l f   T I D s   s e n s i t i v e ) ;   s e e   a l s o   e x i s t i n g   T O D O   o n   T y p e S u p p o r t ' s   a s T e x t P a r a m e t e r   h a n d l e rP R      ����^
�� .ascrerr ****      � ****��  ^ ��_��
�� 
errn_ d      `` m      �������  Q n  1 >aba I   6 >��c���� 60 throwinvalidparametertype throwInvalidParameterTypec ded o   6 7���� 0 aref aRefe fgf m   7 8hh �ii 
 u s i n gg jkj m   8 9��
�� 
ctxtk l��l m   9 :mm �nn  l i s t   o f   t e x t��  ��  b o   1 6���� 0 _support  �� 0 aref aRefN o    ���� 0 delimiterlist delimiterListL opo r   D Iqrq n  D Gsts 1   E G��
�� 
txdlt 1   D E��
�� 
ascrr o      ���� 0 oldtids oldTIDsp uvu r   J Owxw o   J K���� 0 delimiterlist delimiterListx n     yzy 1   L N��
�� 
txdlz 1   K L��
�� 
ascrv {|{ r   P U}~} n   P S� 2  Q S��
�� 
citm� o   P Q���� 0 thetext theText~ o      ���� 0 
resultlist 
resultList| ��� r   V [��� o   V W���� 0 oldtids oldTIDs� n     ��� 1   X Z��
�� 
txdl� 1   W X��
�� 
ascr� ���� L   \ ^�� o   \ ]���� 0 
resultlist 
resultList��  @ � � used by `split text` to split text using one or more text item delimiters and current or predefined considering/ignoring settings   A ���   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   o n e   o r   m o r e   t e x t   i t e m   d e l i m i t e r s   a n d   c u r r e n t   o r   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s8 ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  s v��� I      ������� 0 _splitpattern _splitPattern� ��� o      ���� 0 thetext theText� ���� o      ���� 0 patterntext patternText��  ��  � l    ����� k     ��� ��� Z    ������� =     ��� l    	������ I    	����
�� .corecnte****       ****� J     �� ���� o     ���� 0 patterntext patternText��  � �����
�� 
kocl� m    ��
�� 
list��  ��  ��  � m   	 
���� � r    ��� I   ����
�� .Txt:JoiTnull���     ****� o    ���� 0 patterntext patternText� ���~
� 
Sepa� m    �� ���  |�~  � o      �}�} 0 patterntext patternText��  ��  � ��� r    %��� I    #�|��{�| B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter� ��� o    �z�z 0 patterntext patternText� ��y� m    �� ���  a t�y  �{  � o      �x�x 0 asocpattern asocPattern� ��� r   & 2��� n  & 0��� I   + 0�w��v�w ,0 asnormalizednsstring asNormalizedNSString� ��u� o   + ,�t�t 0 thetext theText�u  �v  � o   & +�s�s 0 _support  � o      �r�r 0 
asocstring 
asocString� ��� l  3 6���� r   3 6��� m   3 4�q�q  � o      �p�p &0 asocnonmatchstart asocNonMatchStart� G A used to calculate NSRanges for non-matching portions of NSString   � ��� �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g� ��� r   7 ;��� J   7 9�o�o  � o      �n�n 0 
resultlist 
resultList� ��� l  < <�m���m  � @ : iterate over each non-matched + matched range in NSString   � ��� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g� ��� r   < M��� n  < K��� I   = K�l��k�l @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o   = >�j�j 0 
asocstring 
asocString� ��� m   > ?�i�i  � ��h� J   ? G�� ��� m   ? @�g�g  � ��f� n  @ E��� I   A E�e�d�c�e 
0 length  �d  �c  � o   @ A�b�b 0 
asocstring 
asocString�f  �h  �k  � o   < =�a�a 0 asocpattern asocPattern� o      �`�`  0 asocmatcharray asocMatchArray� ��� Y   N ���_���^� k   ^ ��� ��� r   ^ k��� l  ^ i��]�\� n  ^ i��� I   d i�[��Z�[ 0 rangeatindex_ rangeAtIndex_� ��Y� m   d e�X�X  �Y  �Z  � l  ^ d��W�V� n  ^ d��� I   _ d�U��T�U  0 objectatindex_ objectAtIndex_� ��S� o   _ `�R�R 0 i  �S  �T  � o   ^ _�Q�Q  0 asocmatcharray asocMatchArray�W  �V  �]  �\  � o      �P�P  0 asocmatchrange asocMatchRange� ��� r   l s��� n  l q��� I   m q�O�N�M�O 0 location  �N  �M  � o   l m�L�L  0 asocmatchrange asocMatchRange� o      �K�K  0 asocmatchstart asocMatchStart� ��� r   t ���� c   t �   l  t ��J�I n  t � I   u ��H�G�H *0 substringwithrange_ substringWithRange_ �F K   u } �E	�E 0 location   o   v w�D�D &0 asocnonmatchstart asocNonMatchStart	 �C
�B�C 
0 length  
 \   x { o   x y�A�A  0 asocmatchstart asocMatchStart o   y z�@�@ &0 asocnonmatchstart asocNonMatchStart�B  �F  �G   o   t u�?�? 0 
asocstring 
asocString�J  �I   m   � ��>
�> 
ctxt� n        ;   � � o   � ��=�= 0 
resultlist 
resultList� �< r   � � [   � � o   � ��;�;  0 asocmatchstart asocMatchStart l  � ��:�9 n  � � I   � ��8�7�6�8 
0 length  �7  �6   o   � ��5�5  0 asocmatchrange asocMatchRange�:  �9   o      �4�4 &0 asocnonmatchstart asocNonMatchStart�<  �_ 0 i  � m   Q R�3�3  � \   R Y l  R W�2�1 n  R W I   S W�0�/�.�0 	0 count  �/  �.   o   R S�-�-  0 asocmatcharray asocMatchArray�2  �1   m   W X�,�, �^  �  l  � ��+�+   "  add final non-matched range    �   8   a d d   f i n a l   n o n - m a t c h e d   r a n g e !"! r   � �#$# c   � �%&% l  � �'�*�)' n  � �()( I   � ��(*�'�( *0 substringfromindex_ substringFromIndex_* +�&+ o   � ��%�% &0 asocnonmatchstart asocNonMatchStart�&  �'  ) o   � ��$�$ 0 
asocstring 
asocString�*  �)  & m   � ��#
�# 
ctxt$ n      ,-,  ;   � �- o   � ��"�" 0 
resultlist 
resultList" ./. l  � �0120 Z  � �34�!� 3 F   � �565 =   � �787 n  � �9:9 1   � ��
� 
leng: o   � ��� 0 
resultlist 
resultList8 m   � ��� 6 =   � �;<; n  � �=>= 1   � ��
� 
leng> n  � �?@? 4   � ��A
� 
cobjA m   � ��� @ o   � ��� 0 
resultlist 
resultList< m   � ���  4 L   � �BB J   � ���  �!  �   1 U O for consistency with _splitText(), where `text items of ""` returns empty list   2 �CC �   f o r   c o n s i s t e n c y   w i t h   _ s p l i t T e x t ( ) ,   w h e r e   ` t e x t   i t e m s   o f   " " `   r e t u r n s   e m p t y   l i s t/ D�D L   � �EE o   � ��� 0 
resultlist 
resultList�  � Q K used by `split text` to split text using a regular expression as separator   � �FF �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   a   r e g u l a r   e x p r e s s i o n   a s   s e p a r a t o r� GHG l     ����  �  �  H IJI l     ����  �  �  J KLK i  w zMNM I      �O�� 0 	_jointext 	_joinTextO PQP o      �� 0 thelist theListQ R�R o      �
�
 0 separatortext separatorText�  �  N k     5SS TUT r     VWV n    XYX 1    �	
�	 
txdlY 1     �
� 
ascrW o      �� 0 oldtids oldTIDsU Z[Z r    \]\ o    �� 0 separatortext separatorText] n     ^_^ 1    
�
� 
txdl_ 1    �
� 
ascr[ `a` Q    ,bcdb r    efe c    ghg o    �� 0 thelist theListh m    �
� 
ctxtf o      �� 0 
resulttext 
resultTextc R      � ��i
�  .ascrerr ****      � ****��  i ��j��
�� 
errnj d      kk m      �������  d k    ,ll mnm r    !opo o    ���� 0 oldtids oldTIDsp n     qrq 1     ��
�� 
txdlr 1    ��
�� 
ascrn s��s R   " ,��tu
�� .ascrerr ****      � ****t m   * +vv �ww b I n v a l i d   d i r e c t   p a r a m e t e r   ( e x p e c t e d   l i s t   o f   t e x t ) .u ��xy
�� 
errnx m   $ %�����Yy ��z{
�� 
erobz o   & '���� 0 thelist theList{ ��|��
�� 
errt| m   ( )��
�� 
list��  ��  a }~} r   - 2� o   - .���� 0 oldtids oldTIDs� n     ��� 1   / 1��
�� 
txdl� 1   . /��
�� 
ascr~ ���� L   3 5�� o   3 4���� 0 
resulttext 
resultText��  L ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ��������  ��  ��  � ��� i  { ~��� I     ����
�� .Txt:SplTnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
Sepa� |����������  ��  � o      ���� 0 theseparator theSeparator��  � l     ������ m      ��
�� 
msng��  ��  � �����
�� 
Usin� |����������  ��  � o      ���� 0 matchformat matchFormat��  � l     ������ m      ��
�� SerECmpI��  ��  ��  � k     ��� ��� l     ������  � � � convenience handler for splitting text using TIDs that can also use a regular expression pattern as separator; similar to Python's str.split()   � ���   c o n v e n i e n c e   h a n d l e r   f o r   s p l i t t i n g   t e x t   u s i n g   T I D s   t h a t   c a n   a l s o   u s e   a   r e g u l a r   e x p r e s s i o n   p a t t e r n   a s   s e p a r a t o r ;   s i m i l a r   t o   P y t h o n ' s   s t r . s p l i t ( )� ���� Q     ����� k    ��� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � o      ���� 0 thetext theText� ��� Z    ������� =    ��� n   ��� 1    ��
�� 
leng� o    ���� 0 thetext theText� m    ����  � L    �� J    ����  ��  ��  � ���� Z   ! ������ =  ! $��� o   ! "���� 0 theseparator theSeparator� m   " #��
�� 
msng� l  ' 3���� L   ' 3�� I   ' 2������� 0 _splitpattern _splitPattern� ��� I  ( -�����
�� .Txt:TrmTnull���     ctxt� o   ( )���� 0 thetext theText��  � ���� m   - .�� ���  \ s +��  ��  � � � if `at` parameter is omitted, trim ends then then split on whitespace runs, same as Python's str.split() default behavior (any `using` options are ignored)   � ���8   i f   ` a t `   p a r a m e t e r   i s   o m i t t e d ,   t r i m   e n d s   t h e n   t h e n   s p l i t   o n   w h i t e s p a c e   r u n s ,   s a m e   a s   P y t h o n ' s   s t r . s p l i t ( )   d e f a u l t   b e h a v i o r   ( a n y   ` u s i n g `   o p t i o n s   a r e   i g n o r e d )� ��� =  6 9��� o   6 7���� 0 matchformat matchFormat� m   7 8��
�� SerECmpI� ��� P   < J���� L   A I�� I   A H������� 0 
_splittext 
_splitText� ��� o   B C���� 0 thetext theText� ���� o   C D���� 0 theseparator theSeparator��  ��  � ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  � ����
�� conscase��  � ��� =  M P��� o   M N���� 0 matchformat matchFormat� m   N O��
�� SerECmpP� ��� L   S [�� I   S Z������� 0 _splitpattern _splitPattern� ��� o   T U���� 0 thetext theText� ���� o   U V���� 0 theseparator theSeparator��  ��  � ��� =  ^ a��� o   ^ _���� 0 matchformat matchFormat� m   _ `��
�� SerECmpC� ��� P   d r����� L   i q�� I   i p������� 0 
_splittext 
_splitText� ��� o   j k���� 0 thetext theText� ���� o   k l���� 0 theseparator theSeparator��  ��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� �� 
�� conswhit  ����
�� consnume��  ��  �  =  u x o   u v���� 0 matchformat matchFormat m   v w��
�� SerECmpE  P   { �	 L   � �

 I   � ���� 0 
_splittext 
_splitText  o   � ��� 0 thetext theText � o   � ��� 0 theseparator theSeparator�  �   �
� conscase �
� consdiac �
� conshyph �
� conspunc ��
� conswhit�  	 ��
� consnume�    =  � � o   � ��� 0 matchformat matchFormat m   � ��
� SerECmpD � L   � � I   � ���~� 0 
_splittext 
_splitText  o   � ��}�} 0 thetext theText �| o   � ��{�{ 0 theseparator theSeparator�|  �~  �  � n  � � I   � ��z�y�z >0 throwinvalidconstantparameter throwInvalidConstantParameter  !  o   � ��x�x 0 matchformat matchFormat! "�w" m   � �## �$$ 
 u s i n g�w  �y   o   � ��v�v 0 _support  ��  � R      �u%&
�u .ascrerr ****      � ****% o      �t�t 0 etext eText& �s'(
�s 
errn' o      �r�r 0 enumber eNumber( �q)*
�q 
erob) o      �p�p 0 efrom eFrom* �o+�n
�o 
errt+ o      �m�m 
0 eto eTo�n  � I   � ��l,�k�l 
0 _error  , -.- m   � �// �00  s p l i t   t e x t. 121 o   � ��j�j 0 etext eText2 343 o   � ��i�i 0 enumber eNumber4 565 o   � ��h�h 0 efrom eFrom6 7�g7 o   � ��f�f 
0 eto eTo�g  �k  ��  � 898 l     �e�d�c�e  �d  �c  9 :;: l     �b�a�`�b  �a  �`  ; <=< i   �>?> I     �_@A
�_ .Txt:JoiTnull���     ****@ o      �^�^ 0 thelist theListA �]B�\
�] 
SepaB |�[�ZC�YD�[  �Z  C o      �X�X 0 separatortext separatorText�Y  D m      EE �FF  �\  ? Q     0GHIG L    JJ I    �WK�V�W 0 	_jointext 	_joinTextK LML n   NON I   	 �UP�T�U 0 aslist asListP Q�SQ o   	 
�R�R 0 thelist theList�S  �T  O o    	�Q�Q 0 _support  M R�PR n   STS I    �OU�N�O "0 astextparameter asTextParameterU VWV o    �M�M 0 separatortext separatorTextW X�LX m    YY �ZZ 
 u s i n g�L  �N  T o    �K�K 0 _support  �P  �V  H R      �J[\
�J .ascrerr ****      � ****[ o      �I�I 0 etext eText\ �H]^
�H 
errn] o      �G�G 0 enumber eNumber^ �F_`
�F 
erob_ o      �E�E 0 efrom eFrom` �Da�C
�D 
errta o      �B�B 
0 eto eTo�C  I I   & 0�Ab�@�A 
0 _error  b cdc m   ' (ee �ff  j o i n   t e x td ghg o   ( )�?�? 0 etext eTexth iji o   ) *�>�> 0 enumber eNumberj klk o   * +�=�= 0 efrom eFroml m�<m o   + ,�;�; 
0 eto eTo�<  �@  = non l     �:�9�8�:  �9  �8  o pqp l     �7�6�5�7  �6  �5  q rsr i  � �tut I     �4v�3
�4 .Txt:SplPnull���     ctxtv o      �2�2 0 thetext theText�3  u Q     $wxyw L    zz n    {|{ 2   �1
�1 
cpar| n   }~} I    �0�/�0 "0 astextparameter asTextParameter ��� o    	�.�. 0 thetext theText� ��-� m   	 
�� ���  �-  �/  ~ o    �,�, 0 _support  x R      �+��
�+ .ascrerr ****      � ****� o      �*�* 0 etext eText� �)��
�) 
errn� o      �(�( 0 enumber eNumber� �'��
�' 
erob� o      �&�& 0 efrom eFrom� �%��$
�% 
errt� o      �#�# 
0 eto eTo�$  y I    $�"��!�" 
0 _error  � ��� m    �� ���   s p l i t   p a r a g r a p h s� ��� o    � �  0 etext eText� ��� o    �� 0 enumber eNumber� ��� o    �� 0 efrom eFrom� ��� o     �� 
0 eto eTo�  �!  s ��� l     ����  �  �  � ��� l     ����  �  �  � ��� i  � ���� I     ���
� .Txt:JoiPnull���     ****� o      �� 0 thelist theList� ���
� 
LiBr� |������  �  � o      �� 0 linebreaktype lineBreakType�  � l     ���� m      �
� LiBrLiOX�  �  �  � Q     ,���� L    �� I    �
��	�
 0 	_jointext 	_joinText� ��� n   ��� I   	 ���� 0 aslist asList� ��� o   	 
�� 0 thelist theList�  �  � o    	�� 0 _support  � ��� I    ���� .0 _aslinebreakparameter _asLineBreakParameter� ��� o    � �  0 linebreaktype lineBreakType� ���� m    �� ��� 
 u s i n g��  �  �  �	  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   " ,������� 
0 _error  � ��� m   # $�� ���  j o i n   p a r a g r a p h s� ��� o   $ %���� 0 etext eText� ��� o   % &���� 0 enumber eNumber� ��� o   & '���� 0 efrom eFrom� ���� o   ' (���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       #�����������������������������������������  � !������������������������������������������������������������������
�� 
pimr�� (0 _unmatchedtexttype _UnmatchedTextType�� $0 _matchedtexttype _MatchedTextType�� &0 _matchedgrouptype _MatchedGroupType�� 0 _support  �� 
0 _error  �� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter�� $0 _matchinforecord _matchInfoRecord�� 0 _matchrecords _matchRecords�� &0 _matchedgrouplist _matchedGroupList�� 0 _findpattern _findPattern�� "0 _replacepattern _replacePattern�� 0 	_findtext 	_findText�� 0 _replacetext _replaceText
�� .Txt:Srchnull���     ctxt
�� .Txt:EPatnull���     ctxt
�� .Txt:ETemnull���     ctxt
�� .Txt:UppTnull���     ctxt
�� .Txt:CapTnull���     ctxt
�� .Txt:LowTnull���     ctxt
�� .Txt:FTxtnull���     ctxt
�� .Txt:Normnull���     ctxt
�� .Txt:PadTnull���     ctxt
�� .Txt:SliTnull���     ctxt
�� .Txt:TrmTnull���     ctxt�� .0 _aslinebreakparameter _asLineBreakParameter�� 0 
_splittext 
_splitText�� 0 _splitpattern _splitPattern�� 0 	_jointext 	_joinText
�� .Txt:SplTnull���     ctxt
�� .Txt:JoiTnull���     ****
�� .Txt:SplPnull���     ctxt
�� .Txt:JoiPnull���     ****� ����� �  �� �����
�� 
cobj� ��   � 
� 
frmk��  
�� 
TxtU
�� 
TxtM
�� 
TxtG� ��   � C
� 
scpt� � M������ 
0 _error  � ��� �  ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�  � ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�  ]��� � &0 throwcommanderror throwCommandError� b  ࠡ����+ � � o������ B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter� ��� �  ��� 0 patterntext patternText� 0 parametername parameterName�  � ��� 0 patterntext patternText� 0 parametername parameterName� ����� ��
� misccura� H0 "nsregularexpressioncaseinsensitive "NSRegularExpressionCaseInsensitive� L0 $nsregularexpressionanchorsmatchlines $NSRegularExpressionAnchorsMatchLines� Z0 +nsregularexpressiondotmatcheslineseparators +NSRegularExpressionDotMatchesLineSeparators� Z0 +nsregularexpressionuseunicodewordboundaries +NSRegularExpressionUseUnicodeWordBoundaries� @0 asnsregularexpressionparameter asNSRegularExpressionParameter�  b  ���,E��,E��,E��,E�m+ � � ������� $0 _matchinforecord _matchInfoRecord� ��� �  ����� 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange� 0 
textoffset 
textOffset� 0 
recordtype 
recordType�  � ������� 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange� 0 
textoffset 
textOffset� 0 
recordtype 
recordType� 0 	foundtext 	foundText�  0 nexttextoffset nextTextOffset� ��������� *0 substringwithrange_ substringWithRange_
� 
ctxt
� 
leng
� 
pcls� 0 
startindex 
startIndex� 0 endindex endIndex� 0 	foundtext 	foundText� � $��k+  �&E�O���,E�O���k���lv� � ������� 0 _matchrecords _matchRecords� ��� �  ����~�}�|� 0 
asocstring 
asocString�  0 asocmatchrange asocMatchRange�  0 asocstartindex asocStartIndex�~ 0 
textoffset 
textOffset�} (0 nonmatchrecordtype nonMatchRecordType�| "0 matchrecordtype matchRecordType�  � �{�z�y�x�w�v�u�t�s�r�q�{ 0 
asocstring 
asocString�z  0 asocmatchrange asocMatchRange�y  0 asocstartindex asocStartIndex�x 0 
textoffset 
textOffset�w (0 nonmatchrecordtype nonMatchRecordType�v "0 matchrecordtype matchRecordType�u  0 asocmatchstart asocMatchStart�t 0 asocmatchend asocMatchEnd�s &0 asocnonmatchrange asocNonMatchRange�r 0 nonmatchinfo nonMatchInfo�q 0 	matchinfo 	matchInfo� �p�o�n�m�l�p 0 location  �o 
0 length  �n �m $0 _matchinforecord _matchInfoRecord
�l 
cobj� W�j+  E�O��j+ E�O�ᦢ�E�O*�����+ E[�k/E�Z[�l/E�ZO*�����+ E[�k/E�Z[�l/E�ZO�����v� �kS�j�i���h�k &0 _matchedgrouplist _matchedGroupList�j �g �g    �f�e�d�c�f 0 
asocstring 
asocString�e 0 	asocmatch 	asocMatch�d 0 
textoffset 
textOffset�c &0 includenonmatches includeNonMatches�i  � �b�a�`�_�^�]�\�[�Z�Y�X�W�V�b 0 
asocstring 
asocString�a 0 	asocmatch 	asocMatch�` 0 
textoffset 
textOffset�_ &0 includenonmatches includeNonMatches�^ "0 submatchresults subMatchResults�] 0 groupindexes groupIndexes�\ (0 asocfullmatchrange asocFullMatchRange�[ &0 asocnonmatchstart asocNonMatchStart�Z $0 asocfullmatchend asocFullMatchEnd�Y 0 i  �X 0 nonmatchinfo nonMatchInfo�W 0 	matchinfo 	matchInfo�V &0 asocnonmatchrange asocNonMatchRange� 	�U�T�S�R�Q�P�O�N�M�U  0 numberofranges numberOfRanges�T 0 rangeatindex_ rangeAtIndex_�S 0 location  �R 
0 length  �Q �P 0 _matchrecords _matchRecords
�O 
cobj�N �M $0 _matchinforecord _matchInfoRecord�h �jvE�O�j+  kE�O�j ��jk+ E�O�j+ E�O��j+ E�O Uk�kh 	*���k+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO��6F[OY��O� #�㨧�E�O*���b  �+ �k/�6FY hY hO�� �L��K�J�I�L 0 _findpattern _findPattern�K �H�H   �G�F�E�D�G 0 thetext theText�F 0 patterntext patternText�E &0 includenonmatches includeNonMatches�D  0 includematches includeMatches�J   �C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�C 0 thetext theText�B 0 patterntext patternText�A &0 includenonmatches includeNonMatches�@  0 includematches includeMatches�? 0 asocpattern asocPattern�> 0 
asocstring 
asocString�= &0 asocnonmatchstart asocNonMatchStart�< 0 
textoffset 
textOffset�; 0 
resultlist 
resultList�:  0 asocmatcharray asocMatchArray�9 0 i  �8 0 	asocmatch 	asocMatch�7 0 nonmatchinfo nonMatchInfo�6 0 	matchinfo 	matchInfo�5 0 	foundtext 	foundText ��4 
�3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� ��4 (0 asbooleanparameter asBooleanParameter�3 B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter�2 ,0 asnormalizednsstring asNormalizedNSString�1 
0 length  �0 @0 matchesinstring_options_range_ matchesInString_options_range_�/ 	0 count  �.  0 objectatindex_ objectAtIndex_�- 0 rangeatindex_ rangeAtIndex_�, �+ 0 _matchrecords _matchRecords
�* 
cobj�) �( 0 foundgroups foundGroups�' 0 
startindex 
startIndex�& &0 _matchedgrouplist _matchedGroupList�% *0 substringfromindex_ substringFromIndex_
�$ 
ctxt
�# 
pcls�" 0 endindex endIndex
�! 
leng�  0 	foundtext 	foundText� �I	b  ��l+ E�Ob  ��l+ E�O*��l+ E�Ob  �k+ E�OjE�OkE�OjvE�O��jj�j+ lvm+ E�O }j�j+ kkh 
��k+ 	E�O*��jk+ 
��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO� ��*���a ,��+ l%�6FY h[OY��O� 1��k+ a &E�Oa b  a �a �a ,a �a �6FY hO�� ������ "0 _replacepattern _replacePattern� ��   ���� 0 thetext theText� 0 patterntext patternText� 0 templatetext templateText�   �������������
�	������� 0 thetext theText� 0 patterntext patternText� 0 templatetext templateText� 0 
asocstring 
asocString� 0 asocpattern asocPattern� 0 
resultlist 
resultList� &0 asocnonmatchstart asocNonMatchStart� 0 
textoffset 
textOffset�  0 asocmatcharray asocMatchArray� 0 i  � 0 	asocmatch 	asocMatch� 0 nonmatchinfo nonMatchInfo�
 0 	matchinfo 	matchInfo�	 0 matchedgroups matchedGroups� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 0 oldtids oldTIDs� 0 
resulttext 
resultText ���� ����������������������������������������x���������� ,0 asnormalizednsstring asNormalizedNSString� B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter
�  
kocl
�� 
scpt
�� .corecnte****       ****
�� 
cobj�� 
0 length  �� @0 matchesinstring_options_range_ matchesInString_options_range_�� 	0 count  ��  0 objectatindex_ objectAtIndex_�� 0 rangeatindex_ rangeAtIndex_�� �� 0 _matchrecords _matchRecords�� �� 0 	foundtext 	foundText�� 0 
startindex 
startIndex�� &0 _matchedgrouplist _matchedGroupList��  0 replacepattern replacePattern
�� 
ctxt�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����	
�� 
erob�� 0 efrom eFrom	 ������
�� 
errt�� 
0 eto eTo��  
�� 
errn
�� 
erob
�� 
errt�� *0 substringfromindex_ substringFromIndex_
�� 
ascr
�� 
txdl�� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_�Lb  �k+  E�O*��l+ E�O�kv��l k jvjkmvE[�k/E�Z[�l/E�Z[�m/E�ZO��jj�j+ lvm+ E�O �j�j+ 	kkh 	��k+ 
E�O*��jk+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO��,�6FO*���a ,e�+ E�O ���,�l+ a &�6FW X  )a �a ] a ] �a �%[OY�qO��k+ a &�6FO_ a ,E^ Oa _ a ,FO�a &E^ O] _ a ,FO] Y ��jj�j+ lv��+ a &� �������
���� 0 	_findtext 	_findText�� ����   ���������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches��  
 
���������������������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 
resultlist 
resultList�� 0 oldtids oldTIDs�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 0 i   ����������������������X�����
�� 
ascr
�� 
txdl
�� 
citm
�� 
leng
�� 
ctxt
�� 
pcls�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� .corecnte****       ****�� 0 foundgroups foundGroups�� 
��
jvE�O��,E�O���,FOkE�O��k/�,E�O� 0�� �[�\[Z�\Z�2E�Y �E�O�b  �����6FY hO �l��-j kh 	�kE�O��,�[�\[�/\�i/2�,E�O� 3�� �[�\[Z�\Z�2E�Y �E�O�b  ����jv��6FY hO�kE�O���/�,kE�O� 0�� �[�\[Z�\Z�2E�Y �E�O�b  �����6FY h[OY�aO���,FO�� �������� 0 _replacetext _replaceText� ��   ���� 0 thetext theText� 0 fortext forText� 0 newtext newText�   ��������������� 0 thetext theText� 0 fortext forText� 0 newtext newText� 0 oldtids oldTIDs� 0 
resultlist 
resultList� 0 
startindex 
startIndex� 0 endindex endIndex� 0 i  � 0 	foundtext 	foundText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 0 
resulttext 
resultText ���������1������M{��
� 
ascr
� 
txdl
� 
kocl
� 
scpt
� .corecnte****       ****
� 
citm
� 
leng
� 
cobj
� 
ctxt� 0 replacetext replaceText� 0 etext eText ��
� 
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  
� 
errn
� 
erob
� 
errt� � "0 astextparameter asTextParameter�(��,E�O���,FO�kv��l j �jvk��k/�,mvE[�k/E�Z[�l/E�Z[�m/E�ZO�� �[�\[Z�\Z�2�6FY hO �l��-j kh �kE�O��,�[�\[�/\�i/2�,E�O�� �[�\[Z�\Z�2E�Y �E�O ��k+ 
�&�6FW X  )����a a �%O�kE�O���/�,kE�O�� �[�\[Z�\Z�2�6FY h[OY�rOa ��,FY b  �a l+ E�O��-E�O���,FO��&E�O���,FO�� �����
� .Txt:Srchnull���     ctxt� 0 thetext theText� ��
� 
For_� 0 fortext forText �
� 
Usin {���� 0 matchformat matchFormat�  
� SerECmpI �
� 
Repl {���� 0 newtext newText�  
� 
msng ��
� 
Retu {���� 0 resultformat resultFormat�  
� RetEMatT�   ���~�}�|�{�z�y�x�w�v� 0 thetext theText� 0 fortext forText�~ 0 matchformat matchFormat�} 0 newtext newText�| 0 resultformat resultFormat�{ &0 includenonmatches includeNonMatches�z  0 includematches includeMatches�y 0 etext eText�x 0 enumber eNumber�w 0 efrom eFrom�v 
0 eto eTo 0��u��t�s�r�q�p��o�n�m�l�k�j"�i�h�g�f[�e�def�c�b�a�`��_���^�����]�\@DW�[d�Z�Y�u "0 astextparameter asTextParameter
�t 
leng
�s 
errn�r�Y
�q 
erob�p 
�o 
msng
�n RetEMatT
�m 
pcls�l 0 
startindex 
startIndex�k 0 endindex endIndex�j 0 	foundtext 	foundText�i 
�h 
cobj
�g RetEUmaT
�f RetEAllT�e >0 throwinvalidconstantparameter throwInvalidConstantParameter
�d SerECmpI�c 0 	_findtext 	_findText
�b SerECmpP�a 0 _findpattern _findPattern
�` SerECmpC
�_ SerECmpE
�^ SerECmpD�] 0 _replacetext _replaceText�\ "0 _replacepattern _replacePattern�[ 0 etext eText �X�W
�X 
errn�W 0 enumber eNumber �V�U
�V 
erob�U 0 efrom eFrom �T�S�R
�T 
errt�S 
0 eto eTo�R  �Z �Y 
0 _error  �P;b  ��l+ E�Ob  ��l+ E�O��,j  )�����Y hO�� L��,j  $��  jvY �b  �k�j��a kvY hO��  felvE[a k/E�Z[a l/E�ZY S�a   eflvE[a k/E�Z[a l/E�ZY 1�a   eelvE[a k/E�Z[a l/E�ZY b  �a l+ O�a   a a  *�����+ VY ��a   *�����+ Y w�a   a g *�����+ VY Z�a   a a   *�����+ VY ;�a !  &�a "  )����a #Y hO*�����+ Y b  �a $l+ Y ���,j  	a %Y hO�a   a a  *���m+ &VY ��a   *���m+ 'Y t�a   a a   *���m+ &VY V�a   a g *���m+ &VY :�a !  %�a (  )����a )Y hO*���m+ &Y b  �a *l+ W X + ,*a -����a .+ /� �Qt�P�O�N
�Q .Txt:EPatnull���     ctxt�P 0 thetext theText�O   �M�L�K�J�I�M 0 thetext theText�L 0 etext eText�K 0 enumber eNumber�J 0 efrom eFrom�I 
0 eto eTo �H�G��F�E�D�C ��B�A
�H misccura�G *0 nsregularexpression NSRegularExpression�F "0 astextparameter asTextParameter�E 40 escapedpatternforstring_ escapedPatternForString_
�D 
ctxt�C 0 etext eText  �@�?!
�@ 
errn�? 0 enumber eNumber! �>�="
�> 
erob�= 0 efrom eFrom" �<�;�:
�< 
errt�; 
0 eto eTo�:  �B �A 
0 _error  �N + ��,b  ��l+ k+ �&W X  *衢���+ 
� �9��8�7#$�6
�9 .Txt:ETemnull���     ctxt�8 0 thetext theText�7  # �5�4�3�2�1�5 0 thetext theText�4 0 etext eText�3 0 enumber eNumber�2 0 efrom eFrom�1 
0 eto eTo$ �0�/��.�-�,�+%��*�)
�0 misccura�/ *0 nsregularexpression NSRegularExpression�. "0 astextparameter asTextParameter�- 60 escapedtemplateforstring_ escapedTemplateForString_
�, 
ctxt�+ 0 etext eText% �(�'&
�( 
errn�' 0 enumber eNumber& �&�%'
�& 
erob�% 0 efrom eFrom' �$�#�"
�$ 
errt�# 
0 eto eTo�"  �* �) 
0 _error  �6 + ��,b  ��l+ k+ �&W X  *衢���+ 
� �!�� �()�
�! .Txt:UppTnull���     ctxt�  0 thetext theText� �*�
� 
Loca* {���� 0 
localecode 
localeCode�  
� 
msng�  ( �������� 0 thetext theText� 0 
localecode 
localeCode� 0 
asocstring 
asocString� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo) ���������
+%�	�� "0 astextparameter asTextParameter� 0 
asnsstring 
asNSString
� 
msng� "0 uppercasestring uppercaseString
� 
ctxt� *0 asnslocaleparameter asNSLocaleParameter� 80 uppercasestringwithlocale_ uppercaseStringWithLocale_�
 0 etext eText+ ��,
� 
errn� 0 enumber eNumber, ��-
� 
erob� 0 efrom eFrom- ���
� 
errt� 
0 eto eTo�  �	 � 
0 _error  � Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ � � 5����./��
�  .Txt:CapTnull���     ctxt�� 0 thetext theText�� ��0��
�� 
Loca0 {�������� 0 
localecode 
localeCode��  
�� 
msng��  . ���������������� 0 thetext theText�� 0 
localecode 
localeCode�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo/ M����������j������1v������ "0 astextparameter asTextParameter�� 0 
asnsstring 
asNSString
�� 
msng�� &0 capitalizedstring capitalizedString
�� 
ctxt�� *0 asnslocaleparameter asNSLocaleParameter�� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_�� 0 etext eText1 ����2
�� 
errn�� 0 enumber eNumber2 ����3
�� 
erob�� 0 efrom eFrom3 ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ � �������45��
�� .Txt:LowTnull���     ctxt�� 0 thetext theText�� ��6��
�� 
Loca6 {�������� 0 
localecode 
localeCode��  
�� 
msng��  4 ���������������� 0 thetext theText�� 0 
localecode 
localeCode�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo5 ������������������7������� "0 astextparameter asTextParameter�� 0 
asnsstring 
asNSString
�� 
msng�� "0 lowercasestring lowercaseString
�� 
ctxt�� *0 asnslocaleparameter asNSLocaleParameter�� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_�� 0 etext eText7 ����8
�� 
errn�� 0 enumber eNumber8 ����9
�� 
erob�� 0 efrom eFrom9 �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  �� Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ � ����:;�
� .Txt:FTxtnull���     ctxt� 0 templatetext templateText� ���
� 
Usin� 0 	thevalues 	theValues�  : ������������������� 0 templatetext templateText� 0 	thevalues 	theValues� 0 asocpattern asocPattern� 0 
asocstring 
asocString�  0 asocmatcharray asocMatchArray� 0 resulttexts resultTexts� 0 
startindex 
startIndex� 0 i  � 0 
matchrange 
matchRange� 0 thetoken theToken� 0 	itemindex 	itemIndex� 0 theitem theItem� 0 oldtids oldTIDs� 0 
resulttext 
resultText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo; (�������������������	i���<�����	�	����	��=	���� 0 aslist asList
� misccura� *0 nsregularexpression NSRegularExpression
� 
msng� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_� 0 
asnsstring 
asNSString� 
0 length  � @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_� 0 location  � � *0 substringwithrange_ substringWithRange_
� 
ctxt
� 
cha 
� 
long
� 
cobj�  < ���
� 
errn��\�  
� 
errn��\
� 
erob
� 
errt� � *0 substringfromindex_ substringFromIndex_
� 
ascr
� 
txdl� 0 etext eText= ��>
� 
errn� 0 enumber eNumber> ��?
� 
erob� 0 efrom eFrom? ���~
� 
errt� 
0 eto eTo�~  � � 
0 _error  �\C��;b  �k+ E�O��,�j�m+ E�Ob  �k+ E�O��jj�j+ 	lvm+ 
E�OjvE�OjE�O �j�j+ kkh ��k+ jk+ E�O���j+ ��k+ a &�6FO��k+ a &E�O�a k/a   �a l/�6FY O�a l/a &E�O�a �/E�O �a &�6FW +X  )a a a �a �/a a a a �%a %O�j+ �j+ 	E�[OY�RO��k+ a &�6FO_  a !,E�Oa "_  a !,FO�a &E�O�_  a !,FO�VW X # $*a %��] ] a &+ '� �}
�|�{@A�z
�} .Txt:Normnull���     ctxt�| 0 thetext theText�{ �yBC
�y 
NoFoB {�x�wD�x 0 nopts nOpts�w  D �vE�v E  �u
�u LiBrLiOXC �tF�s
�t 
LocaF {�r�q
�r 0 
localecode 
localeCode�q  �s  @ �p�o�n�m�l�k�j�i�h�g�f�p 0 thetext theText�o 0 nopts nOpts�n 0 
localecode 
localeCode�m 0 	linebreak 	lineBreak�l 0 
asocstring 
asocString�k 0 foldingflags foldingFlags�j 0 didnormalize didNormalize�i 0 etext eText�h 0 enumber eNumber�g 0 efrom eFrom�f 
0 eto eToA :
)�e�d�c
A�b�a�`�_�^�]�\�[
��Z�Y
��X�W�V�U�T�S�R�Q�P-�O�N�M�L�K�JKc��I�H�G��F�E��D�C��B�AG	�@�?�>H�=�<�e "0 astextparameter asTextParameter�d 0 aslist asList
�c 
leng
�b LiBrLiOX
�a 
cpar
�` 
lnfd�_ 0 	_jointext 	_joinText
�^ 
msng
�] LiBrLiCM
�\ 
errn�[f
�Z 
ret 
�Y LiBrLiWi�X 0 
asnsstring 
asNSString
�W NoFoNoCa
�V NoFoNoDi�U �
�T NoFoNoWi�S �R *0 asnslocaleparameter asNSLocaleParameter�Q H0 "stringbyfoldingwithoptions_locale_ "stringByFoldingWithOptions_locale_
�P NoFoNoSp
�O 
spac
�N misccura�M 60 nsregularexpressionsearch NSRegularExpressionSearch�L 
0 length  �K �J �0 >stringbyreplacingoccurrencesofstring_withstring_options_range_ >stringByReplacingOccurrencesOfString_withString_options_range_
�I NoFoNo_C�H N0 %precomposedstringwithcanonicalmapping %precomposedStringWithCanonicalMapping
�G NoFoNo_D�F L0 $decomposedstringwithcanonicalmapping $decomposedStringWithCanonicalMapping
�E NoFoNoKC�D V0 )precomposedstringwithcompatibilitymapping )precomposedStringWithCompatibilityMapping
�C NoFoNoKD�B T0 (decomposedstringwithcompatibilitymapping (decomposedStringWithCompatibilityMapping�A 0 etext eTextG �;�:�9
�; 
errn�:f�9  
�@ 
list�? .0 throwinvalidparameter throwInvalidParameter
�> 
ctxtH �8�7I
�8 
errn�7 0 enumber eNumberI �6�5J
�6 
erob�5 0 efrom eFromJ �4�3�2
�4 
errt�3 
0 eto eTo�2  �= �< 
0 _error  �z��b  ��l+ E�Ob  �k+ E�O��,j  �Y hO��kv  *��-�l+ Y hO�jv  �Y hO0��kv �E�Y �E�O��kv 0�� )��l�Y hO��,k  *��-�l+ Y hO�E�Y hO��kv 6�� )��la Y hO��,k  *��-��%l+ Y hO��%E�Y hOb  �k+ E�OjE�O�a kv 
�kE�Y hO�a kv �a E�Y hO�a kv �a E�Y hO�j ��b  �a l+ l+ E�Y hO�a kv g��  #�a _ a a ,j�j+ lva  + !E�Y =�a "�a a ,j�j+ lva  + !E�O�a #_ a a ,j�j+ lva  + !E�Y (�� !�a $�a a ,j�j+ lva  + !E�Y hO�a %kv �j+ &E�OeE�Y fE�O�a 'kv !� )��la (Y hO�j+ )E�OeE�Y hO�a *kv !� )��la +Y hO�j+ ,E�OeE�Y hO�a -kv !� )��la .Y hO�j+ /E�OeE�Y hW X 0 1b  �a 2a 3�a  + 4O�a 5&W X 0 6*a 7����a 8+ 9� �1,�0�/KL�.
�1 .Txt:PadTnull���     ctxt�0 0 thetext theText�/ �-�,M
�- 
toPl�, 0 	textwidth 	textWidthM �+NO
�+ 
CharN {�*�)6�* 0 padtext padText�)  O �(P�'
�( 
FromP {�&�%�$�& 0 whichend whichEnd�%  
�$ LeTrLCha�'  K �#�"�!� ��������# 0 thetext theText�" 0 	textwidth 	textWidth�! 0 padtext padText�  0 whichend whichEnd� 0 
widthtoadd 
widthToAdd� 0 padsize padSize� 0 	padoffset 	padOffset� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToL J�V��r��������� ��Q��
� "0 astextparameter asTextParameter� (0 asintegerparameter asIntegerParameter
� 
leng
� 
errn��Y
� 
erob� 
� LeTrLCha
� 
ctxt
� LeTrTCha
� LeTrBCha� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0 etext eTextQ �	�R
�	 
errn� 0 enumber eNumberR ��S
� 
erob� 0 efrom eFromS ���
� 
errt� 
0 eto eTo�  � �
 
0 _error  �. �b  ��l+ E�Ob  ��l+ E�O���,E�O�j �Y hOb  ��l+ E�O��,E�O��,j  )�����Y hO h��,����%E�[OY��O��  �[�\[Zk\Z�2�%Y s��  ��,�#E�O��[�\[Zk�\Z��2%Y P��  ?�k �[�\[Zk\Z�l"2�%E�Y hO��,�#E�O��[�\[Zk�\Z��kl"2%Y b  ��l+ W X  *a ����a + � ��� TU��
� .Txt:SliTnull���     ctxt� 0 thetext theText�  ��VW
�� 
FIdxV {�������� 0 
startindex 
startIndex��  
�� 
msngW ��X��
�� 
TIdxX {�������� 0 endindex endIndex��  
�� 
msng��  T ������������������ 0 thetext theText�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	thelength 	theLength�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToU 6������������R_f��z����������������YN������ "0 astextparameter asTextParameter
�� 
leng
�� 
errn���Y
�� 
erob�� 
�� 
msng�� (0 asintegerparameter asIntegerParameter
�� 
ctxt���[
�� 
bool�� 0 etext eTextY ����Z
�� 
errn�� 0 enumber eNumberZ ����[
�� 
erob�� 0 efrom eFrom[ ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ����b  ��l+ E�O��,E�O�j  -�j  )�����Y hO�j  )�����Y hO�Y hO�� Tb  ��l+ E�O�j  )�����Y hO��  )��' �Y �� �Y �[�\[Z�\Zi2EY hY ��  )�a la Y hO�� Zb  �a l+ E�O�j  )����a Y hO��  +��' 	a Y �� �Y �[�\[Zk\Z�2EY hY hO�j �k�E�Y hO�j �k�E�Y hO��
 �k	 	�ka &a &
 ��	 	��a &a & 	a Y hO�k kE�Y �� �E�Y hO�k kE�Y �� �E�Y hO�[�\[Z�\Z�2EW X  *a ����a + � ��^����\]��
�� .Txt:TrmTnull���     ctxt�� 0 thetext theText�� ��^��
�� 
From^ {�������� 0 whichend whichEnd��  
�� LeTrBCha��  \ ������������������ 0 thetext theText�� 0 whichend whichEnd�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo] s������������������������_����� "0 astextparameter asTextParameter
�� LeTrLCha
�� LeTrTCha
�� LeTrBCha�� >0 throwinvalidconstantparameter throwInvalidConstantParameter
�� 
cobj
�� 
cha 
�� 
ctxt� 0 etext eText_ ��`
� 
errn� 0 enumber eNumber` ��a
� 
erob� 0 efrom eFroma ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �� � �b  ��l+ E�O���mv�kv b  ��l+ Y hO�� {��  �Y hOkilvE[�k/E�Z[�l/E�ZO��lv�kv  h��/� �kE�[OY��Y hO��lv�kv  h��/� �kE�[OY��Y hO�[�\[Z�\Z�2EVW X  *a ����a + � ���bc�� .0 _aslinebreakparameter _asLineBreakParameter� �d� d  ��� 0 linebreaktype lineBreakType� 0 parametername parameterName�  b ��� 0 linebreaktype lineBreakType� 0 parametername parameterNamec ������
� LiBrLiOX
� 
lnfd
� LiBrLiCM
� 
ret 
� LiBrLiWi� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0��  �EY %��  �Y ��  	��%Y b  ��l+ � �:��ef�� 0 
_splittext 
_splitText� �g� g  ��� 0 thetext theText� 0 theseparator theSeparator�  e ������� 0 thetext theText� 0 theseparator theSeparator� 0 delimiterlist delimiterList� 0 aref aRef� 0 oldtids oldTIDs� 0 
resultlist 
resultListf �������hhm�������� 0 aslist asList
� 
kocl
� 
cobj
� .corecnte****       ****
� 
pcnt
� 
ctxt�  h ������
�� 
errn���\��  � � 60 throwinvalidparametertype throwInvalidParameterType
� 
ascr
�� 
txdl
�� 
citm� _b  �k+  E�O 5�[��l kh  ��,�&��,FW X  b  �����+ [OY��O��,E�O���,FO��-E�O���,FO�� �������ij���� 0 _splitpattern _splitPattern�� ��k�� k  ������ 0 thetext theText�� 0 patterntext patternText��  i 
����������~�}�|�{�z�� 0 thetext theText�� 0 patterntext patternText�� 0 asocpattern asocPattern�� 0 
asocstring 
asocString� &0 asocnonmatchstart asocNonMatchStart�~ 0 
resultlist 
resultList�}  0 asocmatcharray asocMatchArray�| 0 i  �{  0 asocmatchrange asocMatchRange�z  0 asocmatchstart asocMatchStartj �y�x�w�v��u��t�s�r�q�p�o�n�m�l�k�j�i�h�g�f
�y 
kocl
�x 
list
�w .corecnte****       ****
�v 
Sepa
�u .Txt:JoiTnull���     ****�t B0 _asnsregularexpressionparameter _asNSRegularExpressionParameter�s ,0 asnormalizednsstring asNormalizedNSString�r 
0 length  �q @0 matchesinstring_options_range_ matchesInString_options_range_�p 	0 count  �o  0 objectatindex_ objectAtIndex_�n 0 rangeatindex_ rangeAtIndex_�m 0 location  �l �k *0 substringwithrange_ substringWithRange_
�j 
ctxt�i *0 substringfromindex_ substringFromIndex_
�h 
leng
�g 
cobj
�f 
bool�� Ρkv��l k  ���l E�Y hO*��l+ E�Ob  �k+ E�OjE�OjvE�O��jj�j+ 	lvm+ 
E�O Hj�j+ kkh ��k+ jk+ E�O�j+ E�O��驤�k+ a &�6FO��j+ 	E�[OY��O��k+ a &�6FO�a ,k 	 �a k/a ,j a & jvY hO�� �eN�d�clm�b�e 0 	_jointext 	_joinText�d �an�a n  �`�_�` 0 thelist theList�_ 0 separatortext separatorText�c  l �^�]�\�[�^ 0 thelist theList�] 0 separatortext separatorText�\ 0 oldtids oldTIDs�[ 0 
resulttext 
resultTextm �Z�Y�X�Wo�V�U�T�S�R�Qv
�Z 
ascr
�Y 
txdl
�X 
ctxt�W  o �P�O�N
�P 
errn�O�\�N  
�V 
errn�U�Y
�T 
erob
�S 
errt
�R 
list�Q �b 6��,E�O���,FO 
��&E�W X  ���,FO)�������O���,FO�� �M��L�Kpq�J
�M .Txt:SplTnull���     ctxt�L 0 thetext theText�K �Irs
�I 
Separ {�H�G�F�H 0 theseparator theSeparator�G  
�F 
msngs �Et�D
�E 
Usint {�C�B�A�C 0 matchformat matchFormat�B  
�A SerECmpI�D  p �@�?�>�=�<�;�:�@ 0 thetext theText�? 0 theseparator theSeparator�> 0 matchformat matchFormat�= 0 etext eText�< 0 enumber eNumber�; 0 efrom eFrom�: 
0 eto eToq ��9�8�7�6��5�4���3�2�1��0	�/#�.�-u/�,�+�9 "0 astextparameter asTextParameter
�8 
leng
�7 
msng
�6 .Txt:TrmTnull���     ctxt�5 0 _splitpattern _splitPattern
�4 SerECmpI�3 0 
_splittext 
_splitText
�2 SerECmpP
�1 SerECmpC
�0 SerECmpE
�/ SerECmpD�. >0 throwinvalidconstantparameter throwInvalidConstantParameter�- 0 etext eTextu �*�)v
�* 
errn�) 0 enumber eNumberv �(�'w
�( 
erob�' 0 efrom eFromw �&�%�$
�& 
errt�% 
0 eto eTo�$  �, �+ 
0 _error  �J � �b  ��l+ E�O��,j  jvY hO��  *�j �l+ Y z��  �� *��l+ 
VY c��  *��l+ Y R��  �g *��l+ 
VY ;��  �a  *��l+ 
VY "�a   *��l+ 
Y b  �a l+ W X  *a ����a + � �#?�"�!xy� 
�# .Txt:JoiTnull���     ****�" 0 thelist theList�! �z�
� 
Sepaz {��E� 0 separatortext separatorText�  �  x ������� 0 thelist theList� 0 separatortext separatorText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToy 	�Y���{e��� 0 aslist asList� "0 astextparameter asTextParameter� 0 	_jointext 	_joinText� 0 etext eText{ ��|
� 
errn� 0 enumber eNumber| ��}
� 
erob� 0 efrom eFrom} ��
�	
� 
errt�
 
0 eto eTo�	  � � 
0 _error  �  1  *b  �k+  b  ��l+ l+ W X  *梣���+ � �u��~�
� .Txt:SplPnull���     ctxt� 0 thetext theText�  ~ ����� � 0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom�  
0 eto eTo ��������������� "0 astextparameter asTextParameter
�� 
cpar�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � % b  ��l+ �-EW X  *塢���+ � �����������
�� .Txt:JoiPnull���     ****�� 0 thelist theList�� �����
�� 
LiBr� {�������� 0 linebreaktype lineBreakType��  
�� LiBrLiOX��  � �������������� 0 thelist theList�� 0 linebreaktype lineBreakType�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� 	����������������� 0 aslist asList�� .0 _aslinebreakparameter _asLineBreakParameter�� 0 	_jointext 	_joinText�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� - *b  �k+  *��l+ l+ W X  *梣���+  ascr  ��ޭ