/**
 * iframe 加载 URL 白名单校验
 */
const ALLOWED_ORIGINS = (import.meta.env.VITE_IFRAME_ALLOWED_ORIGINS || 'http://localhost:8080,http://127.0.0.1:8080')
  .split(',')
  .map((item: string) => item.trim())
  .filter(Boolean);

/** 校验 URL 是否在白名单内 */
export function isAllowedIframeUrl(url: string): boolean {
  if (!url) {
    return false;
  }
  try {
    const parsed = new URL(url, window.location.origin);
    if (parsed.protocol !== 'http:' && parsed.protocol !== 'https:') {
      return false;
    }
    return ALLOWED_ORIGINS.some(origin => parsed.origin === origin || url.startsWith(origin));
  } catch {
    return false;
  }
}

/** 安全解码 iframe URL，非法则返回空字符串 */
export function resolveIframeUrl(rawUrl: string): string {
  if (!rawUrl) {
    return '';
  }
  let decoded = rawUrl;
  try {
    decoded = decodeURIComponent(rawUrl);
  } catch {
    return '';
  }
  return isAllowedIframeUrl(decoded) ? decoded : '';
}
