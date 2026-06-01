String getImageUrl(String imageId) =>
    'https://images.igdb.com/igdb/image/upload/t_1080p/$imageId.webp';

String escapeSearchTerm(String value) =>
    value.replaceAll(r'\', r'\\').replaceAll('"', r'\"');
