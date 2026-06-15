#include "libasm.h"

int	main(void)
{
	char	*str;
	char	*dup;
	int		fd;
	char	buffer[100];
	int		i;
	
	printf("\nft_read\n");
	fd = open("test.txt", O_RDONLY);
	if (fd == -1)
		return (1);
	i = 0;
	while (ft_read(fd, &buffer[i], 1) > 0)
		i++;
	buffer[i] = '\0';
	printf("read: %s\n", buffer);
	close(fd);
	return (0);
	printf("\nft_write\n");
	ft_write(1, "ok ceci est un test\n", 6);
	

	printf("strlen test:\n");
	printf("ft_strlen(\"test\"): %ld\n", (long)ft_strlen("test"));
	printf("str empty: %ld\n", (long)ft_strlen(""));

	printf("\nstrcmp test\n");
	printf("a & a: %d\n", ft_strcmp("a", "a"));
	printf("a & b: %d\n", ft_strcmp("a", "b"));

	printf("\nstrcpy test\n");
	str = malloc(10);
	str = ft_strcpy(str, "saucisson");
	printf("strcpy: %s\n", str);
	printf("\nft_strdup test:\n");
	dup = ft_strdup(str);
	printf("strdup: %s\n", dup);
	free(str);
	free(dup);

	return (0);
}